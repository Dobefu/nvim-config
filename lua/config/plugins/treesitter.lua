local treesitter_configs = require('nvim-treesitter.configs')

treesitter_configs.setup({
  ensure_installed = {
    'c',
    'comment',
    'css',
    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
    'html',
    'javascript',
    'json',
    'jsonc',
    'latex',
    'lua',
    'markdown',
    'php',
    'phpdoc',
    'regex',
    'sql',
    'tsx',
    'typescript',
    'vue',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

vim.treesitter.language.register('markdown', 'mdx')
vim.treesitter.language.register('markdown', 'codecompanion')
