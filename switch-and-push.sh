#!/usr/bin/env bash
set -euo pipefail

# CHANGE THESE:
FLAKE_REF=".#myThonkpad"         # e.g. .#laptop or .#work
BRANCH="main"                # or master
TAG_PREFIX="switched"

# Ensure we’re in a git repo
git rev-parse --is-inside-work-tree >/dev/null

# Rebuild first
if sudo nixos-rebuild switch --flake "$FLAKE_REF"; then
  # Only after a successful switch: commit and push current changes (if any)
  if ! git diff --quiet || ! git diff --cached --quiet; then
    git add -A
    if ! git diff --cached --quiet; then
      msg="nixos switch success: $(date -Is)"
      git commit -m "$msg"
    fi
  fi

  # Make sure we’re on the expected branch
  git switch "$BRANCH" >/dev/null 2>&1 || true

  # Push (set upstream on first push)
  git push -u origin "$BRANCH" || git push origin "$BRANCH"

  # Tag the commit we just pushed (if it exists)
  HEAD_SHA="$(git rev-parse HEAD)"
  TAG="${TAG_PREFIX}-$(date +%Y%m%d-%H%M%S)"
  git tag -a "$TAG" "$HEAD_SHA" -m "$TAG (after nixos-rebuild switch)"
  git push --tags
else
  echo "Rebuild failed; not committing/pushing."
  exit 1
fi
