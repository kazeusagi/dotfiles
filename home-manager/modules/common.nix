{
  config,
  lib,
  username,
  homeDirectory,
  pkgs,
  ...
}:

{
  home.stateVersion = "26.05";
  home.username = username;
  home.homeDirectory = homeDirectory;
  programs.home-manager.enable = true;

  imports = [
    ./common/packages.nix
    ./common/fish.nix
    ./common/nvim.nix
    ./common/zed.nix
  ];

  # Warnが出るため明示的に無効化
  programs.man.enable = false;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}
