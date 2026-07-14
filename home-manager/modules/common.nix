{ config, lib, username, homeDirectory, pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    nixd # Nix LSP
    openssh
    fontconfig
    nerd-fonts.symbols-only

    # Overlays
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

    awscli2
    opentofu # terraformは非フリーライセンス(BSL)でビルドが発生するためtofuを使用
    # fish以外のシェルでもterraformをtofuとして実行可能にするためのラッパー
    (pkgs.writeShellScriptBin "terraform" ''
      exec ${pkgs.opentofu}/bin/tofu "$@"
    '')
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      email = "toshiki1098@gmail.com";
      name = "kazeusagi";
    };
  };

  programs.fish = {
    enable = true;
    # 常に実行
    shellInit = ''
      # Nixのパスを追加
      fish_add_path /nix/var/nix/profiles/default/bin
      # Home Manager binのパス追加
      fish_add_path $HOME/.nix-profile/bin
    '';
    # 対話シェル時のみ実行
    interactiveShellInit = ''
      # チュートリアルを非表示
      set -g fish_greeting
    '';
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      cd = "z";
      find = "fd";
      grep = "rg";
      du = "dust";
      df = "duf";
      ps = "procs";
      top = "btm";
      cc = "claude --dangerously-skip-permissions";
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

  # Warnが出るため明示的に無効化
  programs.man.enable = false;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.home-manager.enable = true;
}
