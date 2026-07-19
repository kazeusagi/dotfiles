{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    extraPackages = with pkgs; [ nixd ];

    userSettings = {
      tab_size = 2;

      terminal = {
        font_fallbacks = [ "Symbols Nerd Font Mono" ];
      };
    };
  };
}
