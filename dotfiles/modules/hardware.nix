{ pkgs, modulesPath, ... }:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
    ];
  };

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    radeontop
  ];

  boot.initrd.luks.devices = {
    lvmcrypt = {
      device = "/dev/nvme0n1p5";
      allowDiscards = true;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/51f18f63-9aa3-45fe-9178-aa2183241ef5";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/6C40-80A8";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/51f18f63-9aa3-45fe-9178-aa2183241ef5";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/51f18f63-9aa3-45fe-9178-aa2183241ef5";
      fsType = "btrfs";
      options = [ "subvol=@logs" ];
    };

  fileSystems."/var/cache" =
    {
      device = "/dev/disk/by-uuid/51f18f63-9aa3-45fe-9178-aa2183241ef5";
      fsType = "btrfs";
      options = [ "subvol=@cache" "compress=zstd" ];
    };

  fileSystems."/var/tmp" =
    {
      device = "/dev/disk/by-uuid/51f18f63-9aa3-45fe-9178-aa2183241ef5";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/20edc2e5-d7aa-4fa2-83c1-0dc08883e283"; }];

  networking.useDHCP = false;

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
