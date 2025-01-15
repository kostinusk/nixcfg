{ pkgs, ... }: {
  hm.home.packages = [
    (pkgs.python3.withPackages
      (ps: with ps; [
        # ps.pip
        # virtianenv
        aiogram
        pytest
        ipympl
        ipython
        jupyter
        matplotlib
        mypy
        numpy
        pandas
        scikit-learn
        seaborn
        tqdm
        kaggle
      ]))
    pkgs.devenv
    pkgs.clang
  ];
  virtualisation.docker.enable = true;

  # nixpkgs.config.allowUnfree = true;
  # environment.systemPackages = with pkgs; [
  #   unstable.byedpi
  # ];
}
