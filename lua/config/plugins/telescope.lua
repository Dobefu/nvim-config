local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

local opts = {
  hidden = true,
  no_ignore_parent = true,
  follow = true,
}

vim.keymap.set('n', '<C-p>', function() builtin.find_files(opts) end, { desc = "Find files" })
vim.keymap.set('n', '<C-l>', function() builtin.live_grep(opts) end, { desc = "Live grep" })

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
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
      ".swp$",
      ".png$",
      ".jpg$",
      ".jpeg$",
      ".gif$",
      ".ico$",
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

telescope.load_extension('fzf')
