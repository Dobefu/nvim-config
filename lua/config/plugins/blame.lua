local blame = require('blame')
blame.setup({})

vim.api.nvim_set_keymap('n', '<C-b>', ':BlameToggle<CR>', { desc = "Git Blame" })
