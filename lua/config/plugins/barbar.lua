local barbar = require('barbar')

barbar.setup({
  animation = true,
  -- auto_hide = true,
  clickable = true,
  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    NvimTree = true,
  },
})

vim.api.nvim_set_keymap(
  'n',
  '<leader>q',
  '<Cmd>BufferClose<CR>',
  { noremap = true, silent = true, desc = "Close the current buffer" }
)
