{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
      deadnix
      lazygit
      tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim # Theme
      lualine-nvim # Status Line
      neo-tree-nvim # File Tree
      telescope-fzf-native-nvim # 検索
      gitsigns-nvim # 差分の視覚化
      which-key-nvim # コマンドのキー入力候補の表示
      bufferline-nvim # バッファ一覧をタブに表示
      lazygit-nvim # Git操作
      blink-cmp # 補完
      (nvim-treesitter.withPlugins (
        p: with p; [
          nix
          lua
          typescript
          tsx
          terraform
        ]
      )) # 構文解析およびシンタックスハイライト

      nvim-lspconfig # LSP
      conform-nvim # 基本のフォーマッタ
      nvim-lint # 基本のリンタ

      vim-tmux-navigator # tmuxとの統合

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

      vim.diagnostic.config({ virtual_text = true })

      -- LSP
      local capabilities = require("blink-cmp").get_lsp_capabilities()
      vim.lsp.config('nixd', { capabilities = capabilities })
      vim.lsp.enable('nixd')
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
          ["<Esc>"] = { "hide", "fallback" },
        }
      })
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false

      -- Theme
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

      -- Git
      vim.opt.signcolumn = "yes"
      require("gitsigns").setup()

      -- keymap
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep)
      vim.keymap.set('n', '<leader>fb', builtin.buffers)
      vim.keymap.set("n", "<leader>bda", ":bdelete<CR>", { desc = "バッファを閉じる" })
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
      -- バッファ切り替え
      vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "次のバッファ" })
      vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "前のバッファ" })
      -- tmux統合
      vim.keymap.set('n', '<C-a>', '<Nop>')
      vim.keymap.set('v', '<C-a>', '<Nop>')
    '';
  };
}
