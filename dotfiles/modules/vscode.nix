{ inputs
, pkgs
, lib
, ...
}: {


  hm = {
    home.file.".vscode/argv.json".text = builtins.toJSON {
      enable-crash-reporter = false;
      password-store = "gnome-libsecret";
    };

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      mutableExtensionsDir = false;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions =
        let
          vm = inputs.nix-vscode-extensions.extensions.${pkgs.hostPlatform.system}.vscode-marketplace;
        in
        [
          # Python
          vm.ms-python.python
          vm.ms-python.vscode-pylance
          vm.ms-python.mypy-type-checker
          vm.ms-python.black-formatter
          vm.ms-python.debugpy
          vm.ms-python.isort

          # Jupyter
          pkgs.vscode-extensions.ms-toolsai.jupyter
          pkgs.vscode-extensions.ms-toolsai.jupyter-renderers
          vm.ms-toolsai.datawrangler

          # Other languages
          vm.galarius.vscode-opencl
          vm.jnoortheen.nix-ide
          vm.mechatroner.rainbow-csv
          vm.redhat.vscode-xml
          vm.redhat.vscode-yaml
          vm.tamasfe.even-better-toml
          vm.yzhang.markdown-all-in-one
          vm.james-yu.latex-workshop

          # Tools
          vm.editorconfig.editorconfig
          vm.mkhl.direnv
          vm.stkb.rewrap
          vm.tyriar.sort-lines
          vm.fill-labs.dependi
        ];
      userSettings = {
        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = lib.getExe pkgs.unstable.nixd;
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              command = [ (lib.getExe pkgs.nixpkgs-fmt) ];
            };
            options = {
              nixos = {
                expr = "(builtins.getFlake \"/home/kstnbtw/projects/dotfiles\").nixosConfigurations.fghjk.options";
              };
            };
          };
        };
        # Python
        "python.analysis.autoImportCompletions" = true;

        "black-formatter.path" = [ "${pkgs.black}/bin/black" ];
        "python.formatting.provider" = "black";

        "python.languageServer" = "Pylance";

        "mypy-type-checker.args" = [ "--disable-error-code=import-untyped" ];
        "mypy-type-checker.severity" = {
          "error" = "Warning";
          "note" = "Information";
        };
        # "mypy-type-checker.path" = [ "${pkgs.mypy}/bin/mypy" ];

        "python.poetryPath" = "${pkgs.poetry}/bin/poetry";
        "python.venvPath" = "~/.cache/pypoetry/virtualenvs";

        "isort.path" = [ "${pkgs.python3Packages.isort}/bin/isort" ];

        "python.testing.pytestEnabled" = true;
        "python.testing.pytestPath" = "${pkgs.python3Packages.pytest}/bin/pytest";

        # "jupyter.themeMatplotlibPlots" = true;
        # "python.formatting.blackArgs" = ["-l120" "-tpy311"];

        # VCS
        "diffEditor.ignoreTrimWhitespace" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        # Fonts
        "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'liga'";
        "editor.fontFamily" = "'Monaspace Neon', monospace";
        "terminal.integrated.fontFamily" = "MesloLGS NF";

        # Other
        "direnv.restart.automatic" = true;
        "editor.formatOnSave" = true;
        "editor.quickSuggestions".strings = true;
        "editor.tabCompletion" = "on";
        "editor.unicodeHighlight.allowedLocales".ru = true;
        "files.autoSave" = "afterDelay";
        "redhat.telemetry.enabled" = false;
        "sortLines.filterBlankLines" = true;
        "workbench.startupEditor" = "none";
      };
    };
  };
}
