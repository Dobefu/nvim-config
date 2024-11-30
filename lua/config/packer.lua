if (vim.fn.isdirectory(vim.fn.expand('$HOME/.local/share/nvim/site')) == 0) then
  vim.cmd(
    ':!git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim')
  vim.fn.confirm('Packer has just been installed. Please restart NeoVim to apply the changes', 'Ugh, fine')
  vim.cmd(':q')
end

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')
  use('airblade/vim-rooter')
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use({ 'mistricky/codesnap.nvim', run = 'make' })
  use('nvim-treesitter/nvim-treesitter-context')
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')
  use('saadparwaiz1/cmp_luasnip')
  use('ray-x/lsp_signature.nvim')
  use('L3MON4D3/LuaSnip')
  use('nvim-lua/completion-nvim')
  use('folke/neoconf.nvim')
  use('https://gitlab.com/schrieveslaach/sonarlint.nvim')
  use('j-hui/fidget.nvim')
  use('sontungexpt/better-diagnostic-virtual-text')
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('stevearc/conform.nvim')
  use('xiyaowong/transparent.nvim')
  use('folke/which-key.nvim')
  use('airblade/vim-gitgutter')
  use('nvim-tree/nvim-tree.lua')
  use('romgrk/barbar.nvim')
  use('folke/trouble.nvim')
  use('nvim-tree/nvim-web-devicons')
  use('nvim-lualine/lualine.nvim')
  use('windwp/nvim-autopairs')
  use('numToStr/Comment.nvim')
  use('mfussenegger/nvim-dap')
  use('theHamsta/nvim-dap-virtual-text')
  use('leoluz/nvim-dap-go')
  use('hedyhli/outline.nvim')
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })
  use({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({})
    end,
  })
end)
