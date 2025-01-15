{ pkgs, ... }: {
  # hm.programs.texlive = {
  #   enable = true;
  #   packageSet = pkgs.texlive.scheme-full;
  # };

  services.gnome.games.enable = true;
  hm.home.packages = with pkgs; [
    # texliveFull
    telegram-desktop
    chromium
    webcord-vencord
    libreoffice
  ];

  services.flatpak.enable = true;
}
