{ config, pkgs, ... }:

{
  home.username = "kazeusagi";
  home.homeDirectory = "/home/kazeusagi";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    htop
    ripgrep
    wget
    nixd # Nix LSP
    claude-code
    bun
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "kazeusagi";
      email = "toshiki1098@gmail.com";
    };
  };

  # programs.bash = {
  #   enable = true;
  #   shellAliases = {
  #     ll = "ls -la";
  #   };
  # }

  programs.home-manager.enable = true;
}
