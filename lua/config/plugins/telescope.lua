local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local config = require("telescope.config")

local opts = {
  hidden = true,
  no_ignore = true,
  no_ignore_parent = true,
}

vim.keymap.set('n', '<C-p>', function() builtin.find_files(opts) end, { desc = "Find files" })
vim.keymap.set('n', '<C-l>', function() builtin.live_grep(opts) end, { desc = "Live grep" })

require("telescope").setup({
  defaults = {
    prompt_prefix = " 🔍 ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_tab,
      },
    },
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    preview = {
      treesitter = false,
    },
    file_ignore_patterns = {
      "~$",
      "undodir/",
      ".DS_Store",
      ".git/",
      "swap/",
      ".swp",
      "node_modules/",
      "vendor/",
      "tempformresults/",
      "web/modules/custom/",
      "web/themes/custom/",
      "coverage/",
      ".next/",
      ".nuxt/",
      ".output/",
    },
  },
})
