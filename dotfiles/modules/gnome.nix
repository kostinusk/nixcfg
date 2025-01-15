{ pkgs, ... }: {
  nixcfg.gnome.enable = true;

  services.displayManager.autoLogin.user = "kstnbtw";

  services.xserver.xkb.layout = "us,ru";

  # environment.sessionVariables = {
  #   NIXOS_OZONE_WL = "0";
  # };
  


  environment.systemPackages = with pkgs; [
    gnome3.dconf-editor
  ];

  hm.dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-seconds = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "grp:caps_toggle" "grp_led:caps" ];
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
