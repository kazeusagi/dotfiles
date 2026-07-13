{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.username = "kazeusagi";
  home.homeDirectory = "/home/kazeusagi";
}
