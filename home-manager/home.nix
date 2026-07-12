{ config, pkgs, ... }:

{
  home.username = "kazeusagi";
  home.homeDirectory = "/home/kazeusagi";
  home.stateVersion = "26.05";

  home.packages = [
    pkgs.htop
    pkgs.ripgrep
    pkgs.wget
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "kazeusagi";
      email = "toshiki1098@gmail.com";
    };
  };

  programs.home-manager.enable = true;
}
