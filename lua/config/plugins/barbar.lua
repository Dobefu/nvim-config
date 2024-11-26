local barbar = require('barbar')

barbar.setup({
  animation = true,
  clickable = true,
  sidebar_filetypes = {
    NvimTree = true,
  },
})

vim.api.nvim_set_keymap('n', 'g[', '<Cmd>BufferPrevious<CR>', {})
vim.api.nvim_set_keymap('n', 'g]', '<Cmd>BufferNext<CR>', {})
vim.api.nvim_set_keymap(
  'n',
  '<leader>q',
  '<Cmd>BufferClose<CR>',
  { noremap = true, silent = true, desc = "Close the current buffer" }
)
