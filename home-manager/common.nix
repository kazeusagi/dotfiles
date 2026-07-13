{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nixd # Nix LSP
    claude-code
    bun

    eza        # ls の代替
    bat        # cat の代替(シンタックスハイライト)
    fd         # find の代替
    ripgrep    # grep の代替(rg)
    dust       # du の代替
    duf        # df の代替
    procs      # ps の代替
    bottom     # top の代替(btm)

    jq         # JSON処理
    git
    curl
    wget
    tree
    unzip

    delta      # git diff を見やすく
    tldr       # man の簡易版
    htop
    tmux
  ];

  programs.git = {
    enable = true;
    settings.user = {
      email = "toshiki1098@gmail.com";
      name = "kazeusagi";
    };
  };

  # programs.bash = {
  #   enable = true;
  #   shellAliases = {
  #     ll = "ls -la";
  #   };
  # }

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_add_path /nix/var/nix/profiles/default/bin
      fish_add_path ~/.nix-profile/bin
    '';
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      find = "fd";
      grep = "rg";
      du = "dust";
      df = "duf";
      ps = "procs";
      top = "btm";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    extraPackages = with pkgs; [ nixd ];

    userSettings = {
      tab_size = 2;
    };
  };

  programs.home-manager.enable = true;
}
