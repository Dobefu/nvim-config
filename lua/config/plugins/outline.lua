local outline = require('outline')

outline.setup({
  outline_window = {
    auto_close = true,
  },
  symbol_folding = {
    autofold_depth = 1,
    auto_unfold = {
      hovered = true,
    },
  },
})

vim.keymap.set("n", "<leader>o", ":Outline<CR>", { desc = "Toggle Outline" })
vim.keymap.set("n", "<leader>O", ":Outline!<CR>", { desc = "Toggle Outline without focus" })
