{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.username = "ito.toshiki";
  home.homeDirectory = "/Users/ito.toshiki";
}
