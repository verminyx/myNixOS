{ self, inputs, ... }: {
  flake.nixosConfigurations.myThonkpad = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.myThonkpadConfiguration];
  };
}
