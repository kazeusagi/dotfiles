{ ... }:

{
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
}
