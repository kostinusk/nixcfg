{ lib, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "corefonts"
    "libfprint-2-tod1-goodix"
  ];

  # hm.home.packages = with pkgs; [
  #   steam
  # ];
}
