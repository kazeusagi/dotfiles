{ config, pkgs, ... }:

{
  home.username = "kazeusagi";
  home.homeDirectory = "/home/kazeusagi";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.htop
    pkgs.ripgrep
  ];

  programs.git = {
    enable = true;
    userName = "kazeusagi";
    userEmail = "toshiki1098@gmail.com";
  };

  programs.home-manager.enable = true;
}
