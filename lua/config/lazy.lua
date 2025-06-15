local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
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
    'airblade/vim-rooter',
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      lazy = false,
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
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',
    {
      'ray-x/lsp_signature.nvim',
      event = 'InsertEnter',
    },
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
    'folke/neoconf.nvim',
    'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    'j-hui/fidget.nvim',
    {
      'sontungexpt/better-diagnostic-virtual-text',
      lazy = true,
    },
    'williamboman/mason.nvim',
    {
      'mason-org/mason-lspconfig.nvim',
      opts = {},
      dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'neovim/nvim-lspconfig',
      },
    },
    'stevearc/conform.nvim',
    {
      'xiyaowong/transparent.nvim',
      lazy = false,
    },
    {
      'folke/which-key.nvim',
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
    'lewis6991/gitsigns.nvim',
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
      dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
      },
    },
    {
      'folke/trouble.nvim',
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
    'numToStr/Comment.nvim',
    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',
    {
      'hedyhli/outline.nvim',
      config = function()
        vim.keymap.set('n', '<leader>o', ':Outline<CR>', { desc = 'Toggle Outline' })
        vim.keymap.set('n', '<leader>O', ':Outline!<CR>', { desc = 'Toggle Outline without focus' })
      end,
    },
    'RRethy/vim-illuminate',
    'windwp/nvim-ts-autotag',
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
      dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
      event = { 'CmdlineEnter' },
      ft = { 'go', 'gomod' },
      build = ':lua require("go.install").update_all_sync()',
    },
    {
      'FabijanZulj/blame.nvim',
      lazy = false,
    },
    {
      'pcolladosoto/tinygo.nvim',
      config = function() require('tinygo').setup() end,
      event = 'VeryLazy',
    },
    {
      'folke/noice.nvim',
      event = 'VeryLazy',
      dependencies = {
        'MunifTanjim/nui.nvim',
      }
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
    }
  },
  checker = { enabled = true },
})
