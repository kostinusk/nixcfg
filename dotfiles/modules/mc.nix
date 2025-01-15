{ pkgs
, inputs
, ...
}:
let
  mkNixPak = inputs.nixpak.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };

  sandboxed-prismlauncher = mkNixPak {
    config = { sloth, ... }: {
      app.package = pkgs.prismlauncher;

      bubblewrap = {
        bind.rw = [
          (sloth.concat' sloth.homeDir "/.local/share/PrismLauncher")
        ];
        sockets = {
          wayland = true;
          pipewire = true;
        };
      };

      etc.sslCertificates.enable = true;
      gpu.enable = true;
      locale.enable = true;
      fonts.enable = true;
    };
  };
in
{
  hm = {
    home.packages = [ sandboxed-prismlauncher.config.env ];
  };
}
