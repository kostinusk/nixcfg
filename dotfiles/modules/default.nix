{ inputs, ... }:
{
  imports =
    [
      ./apps.nix
      ./dev.nix
      ./firefox.nix
      ./fonts.nix
      ./gnome.nix
      ./hardware.nix
      ./mc.nix
      ./shell.nix
      ./unfree.nix
      ./users.nix
      ./vscode.nix
    ];

  nixcfg = {
    username = "kstnbtw";
    inherit inputs;
  };

  programs.nh = {
    enable = true;
    flake = "/home/kstnbtw/projects/dotfiles";
  };

  services.snapper.configs = {
    root = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "kstnbtw" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
    };
  };

  networking.hostName = "fghjk";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
  };

  boot = {
    plymouth.enable = true;
    loader.timeout = 0;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  system.stateVersion = "24.05";
}
