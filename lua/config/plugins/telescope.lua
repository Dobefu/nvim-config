local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local config = require("telescope.config")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-l>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--no-ignore-vcs")
table.insert(vimgrep_arguments, "-g")
table.insert(vimgrep_arguments, '!{.git,node_modules,undodir}/*')

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_tab,
      },
    },
    vimgrep_arguments = vimgrep_arguments,
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    preview = {
      treesitter = false,
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--no-ignore-vcs", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" },
    }
  },
}
