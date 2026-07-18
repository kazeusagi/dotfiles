{
  config,
  lib,
  username,
  homeDirectory,
  pkgs,
  ...
}:

{
  home.stateVersion = "26.05";
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs; [
    openssh
    fontconfig
    nerd-fonts.symbols-only

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

  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
      deadnix
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim # Theme
      lualine-nvim # Status Line
      neo-tree-nvim # File Tree
      telescope-fzf-native-nvim # 検索
      gitsigns-nvim
      which-key-nvim
      bufferline-nvim

      nvim-lspconfig
      conform-nvim
      nvim-lint

      # Dependencies
      nvim-web-devicons # UI プラグイン全般が依存するアイコン集
      nui-nvim # UI　コンポーネント
      plenary-nvim # 非同期処理を持つプラグイン全般
    ];
    initLua = ''
      vim.g.mapleader = " "
      vim.opt.timeoutlen = 200 -- <leader>押下時のdelay
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true

      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.tabstop = 2

      vim.opt.list = true
      vim.opt.listchars = { tab = "→ ", trail = "·", space = "·" }

      vim.lsp.config('nixd', {})
      vim.lsp.enable('nixd')
      require('which-key').setup({})
      require('catppuccin').setup({
      })
      vim.cmd.colorscheme("catppuccin")
      require('bufferline').setup()
      require('lualine').setup()
      require('neo-tree').setup({
        window = {
          mappings = {
            ["<space>"] = "none",
            ["l"] = "open",
            ["h"] = "close_node",
       	  }
       	}
      })

      -- フォーマット(保存時に自動実行)
      require('conform').setup({
        formatters_by_ft = { nix = { "nixfmt" } },
        format_on_save = { lsp_fallback = true },
      })

      -- リント(保存時に自動実行)
      require('lint').linters_by_ft = { nix = { "statix" } }
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function() require("lint").try_lint() end,
      })

      -- 初回起動時にNeotreeを表示する
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd("Neotree focus")
        end,
      })

      -- keymap
      vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ" })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ" })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ" })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ" })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
    '';
  };

  programs.starship = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.home-manager.enable = true;
}
