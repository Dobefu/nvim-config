if (vim.fn.isdirectory(vim.fn.expand('$HOME/.local/share/nvim/site')) == 0) then
  vim.cmd(
    ':!git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim')
  vim.fn.confirm('Packer has just been installed. Please restart NeoVim to apply the changes', 'Ugh, fine')
  vim.cmd(':q')
end

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim');

  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  });

  use('airblade/vim-rooter');

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' });

  use('nvim-treesitter/nvim-treesitter-context');

  use('neovim/nvim-lspconfig');
  use('hrsh7th/nvim-cmp');
  use('hrsh7th/cmp-buffer');
  use('hrsh7th/cmp-path');
  use('hrsh7th/cmp-cmdline');
  use('hrsh7th/cmp-nvim-lsp');
  use('saadparwaiz1/cmp_luasnip');
  use('ray-x/lsp_signature.nvim');
  use('L3MON4D3/LuaSnip');
  use('nvim-lua/completion-nvim');
  use('folke/neoconf.nvim');

  use('williamboman/mason.nvim');
  use('williamboman/mason-lspconfig.nvim');
  use('stevearc/conform.nvim');

  use('folke/which-key.nvim');

  use({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({})
    end,
  });

  use('folke/trouble.nvim');

  use('nvim-tree/nvim-web-devicons');

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  });

  use({
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  });

  use({
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  });
end)
