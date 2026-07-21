{ self, inputs, ... }: {

  flake.nixosModules.myThonkpadHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-5102e4c8-8d78-4151-a588-49e8abc06bd4";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-5102e4c8-8d78-4151-a588-49e8abc06bd4".device = "/dev/disk/by-uuid/5102e4c8-8d78-4151-a588-49e8abc06bd4";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6549-7F8D";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
}
