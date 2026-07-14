{ config, lib, pkgs, username, platform, ... }:

{
  imports = [ ./common.nix ]
    ++ lib.optional (platform == "mac") ./mac.nix
    ++ lib.optional (platform == "win") ./win.nix
    ++ lib.optional (platform == "linux") ./linux.nix;

  home.username = username;
  home.homeDirectory =
    if platform == "mac" then "/Users/${username}" else "/home/${username}";
}
