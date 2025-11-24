local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system(
    {
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazypath,
    }
  )

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

require('lazy').setup({
  spec = {
    {
      'airblade/vim-rooter',
      lazy = false,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      event = {
        "BufReadPost",
        "BufNewFile",
      },
      build = ':TSUpdate',
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      lazy = false,
    },
    {
      'mistricky/codesnap.nvim',
      build = 'make',
    },
    {
      'neovim/nvim-lspconfig',
      event = {
        'BufReadPre',
        'BufNewFile',
      },
      dependencies = {
        'mason-org/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
      },
    },
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
      },
    },
    {
      'ray-x/lsp_signature.nvim',
      event = 'InsertEnter',
    },
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    {
      'folke/neoconf.nvim',
      lazy = false,
    },
    {
      'j-hui/fidget.nvim',
      lazy = true,
    },
    {
      'sontungexpt/better-diagnostic-virtual-text',
      lazy = true,
    },
    {
      'mason-org/mason.nvim',
      lazy = true,
    },
    {
      'mason-org/mason-lspconfig.nvim',
      lazy = true,
      dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'neovim/nvim-lspconfig',
      },
    },
    {
      'stevearc/conform.nvim',
      event = 'VeryLazy',
    },
    {
      'xiyaowong/transparent.nvim',
      lazy = false,
    },
    {
      'folke/which-key.nvim',
      lazy = true,
      event = 'VeryLazy',
      keys = {
        {
          '<leader>?',
          function()
            require('which-key').show({ global = false })
          end,
          desc = 'Buffer Local Keymaps (which-key)',
        },
      },
    },
    {
      'lewis6991/gitsigns.nvim',
      lazy = true,
    },
    {
      'nvim-tree/nvim-tree.lua',
      version = '*',
      lazy = false,
      dependencies = {
        'nvim-tree/nvim-web-devicons',
      },
    },
    {
      'romgrk/barbar.nvim',
      lazy = true,
      dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
      },
    },
    {
      'folke/trouble.nvim',
      lazy = true,
      opts = {},
      cmd = 'Trouble',
      keys = {
        {
          '<leader>xx',
          '<cmd>Trouble diagnostics toggle<cr>',
          desc = 'Diagnostics (Trouble)',
        },
        {
          '<leader>xX',
          '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
          desc = 'Buffer Diagnostics (Trouble)',
        },
        {
          '<leader>cs',
          '<cmd>Trouble symbols toggle focus=false<cr>',
          desc = 'Symbols (Trouble)',
        },
        {
          '<leader>cl',
          '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
          desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
          '<leader>xL',
          '<cmd>Trouble loclist toggle<cr>',
          desc = 'Location List (Trouble)',
        },
        {
          '<leader>xQ',
          '<cmd>Trouble qflist toggle<cr>',
          desc = 'Quickfix List (Trouble)',
        },
      },
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = true,
    },
    {
      'numToStr/Comment.nvim',
      event = 'InsertEnter',
    },
    {
      'mfussenegger/nvim-dap',
      lazy = true,
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      lazy = true,
    },
    {
      'leoluz/nvim-dap-go',
      lazy = true,
    },
    {
      'hedyhli/outline.nvim',
      config = function()
        vim.keymap.set(
          'n',
          '<leader>o',
          ':Outline<CR>',
          { desc = 'Toggle Outline' }
        )

        vim.keymap.set(
          'n',
          '<leader>O',
          ':Outline!<CR>',
          { desc = 'Toggle Outline without focus' }
        )
      end,
    },
    {
      'RRethy/vim-illuminate',
      lazy = true,
    },
    {
      'windwp/nvim-ts-autotag',
      lazy = true,
    },
    {
      'christoomey/vim-tmux-navigator',
      cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
        'TmuxNavigatorProcessList',
      },
      keys = {
        { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
        { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
        { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
        { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
        { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
      },
    },
    {
      'ray-x/go.nvim',
      lazy = true,
      dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
      opts = {
        lsp_keymaps = false,
      },
      event = {
        'CmdlineEnter',
      },
      ft = {
        'go',
        'gomod',
      },
      build = ':lua require("go.install").update_all_sync()',
    },
    {
      'FabijanZulj/blame.nvim',
      lazy = false,
    },
    {
      'pcolladosoto/tinygo.nvim',
      event = 'VeryLazy',
      config = function() require('tinygo').setup({}) end,
    },
    {
      'folke/noice.nvim',
      event = 'VeryLazy',
      dependencies = {
        'MunifTanjim/nui.nvim',
      },
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      dependencies = {
        'nvim-telescope/telescope.nvim',
      },
    },
    {
      'nvimdev/lspsaga.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require('lspsaga').setup()
      end,
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      },
      opts = {
        file_types = { 'markdown', 'mdx' },
      },
    },
    {
      'Dobefu/nvim-dlitescript',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    -- {
    --   dir = '~/Projects/Web/Golang/nvim-dlitescript',
    --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
    -- },
  },
  checker = { enabled = false },
})
