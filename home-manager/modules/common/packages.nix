{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openssh

    # Overlays
    claude-code
    bun

    nodejs_26

    eza # ls の代替
    bat # cat の代替(シンタックスハイライト)
    fd # find の代替
    ripgrep # grep の代替(rg)
    dust # du の代替
    duf # df の代替
    procs # ps の代替
    bottom # top の代替(btm)

    jq # JSON処理
    git
    curl
    wget
    tree
    unzip

    delta # git diff を見やすく
    tldr # man の簡易版
    htop

    awscli2
    opentofu # terraformは非フリーライセンス(BSL)でビルドが発生するためtofuを使用
    # fish以外のシェルでもterraformをtofuとして実行可能にするためのラッパー
    (pkgs.writeShellScriptBin "terraform" ''
      exec ${pkgs.opentofu}/bin/tofu "$@"
    '')
  ];

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings.user = {
        email = "toshiki1098@gmail.com";
        name = "kazeusagi";
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };

    # Warnが出るため明示的に無効化
    man.enable = false;
  };
}
