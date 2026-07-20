{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    includes = [ "~/.orbstack/ssh/config" ];
  };
}
