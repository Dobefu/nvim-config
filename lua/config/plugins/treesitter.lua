local treesitter_configs = require('nvim-treesitter.configs')

treesitter_configs.setup({
  ensure_installed = {
    "html",
    "php",
    "javascript",
    "typescript",
    "c",
    "lua",
    "go",
    "vue",
    "tsx",
    "markdown",
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
