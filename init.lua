local config_dir = vim.fn.stdpath('config')

vim.cmd [[colorscheme custom]]

require('config')

vim.opt.shell = '/bin/sh'

-- Set Viminfo file location
vim.opt.shada:append('n' .. config_dir .. '/main.shada')

-- Enable undo history files.
vim.opt.undofile = true
vim.opt.undodir = config_dir .. '/undodir'

-- Enable file backups.
vim.opt.backup = true
vim.opt.backupdir = config_dir .. '/backups'

-- Set a directory for swap files.
vim.opt.directory = config_dir .. '/swap'

-- Set the leader key.
vim.g.mapleader = '\\'

-- always show the tab pages.
vim.opt.hidden = true
vim.opt.showtabline = 2

-- Disable netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Hightlight the line where the cursor is.
vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

-- Set the indents to two spaces.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Enable mouse support, even in Insert mode.
vim.opt.mouse = 'a'

-- Set the clipboard to the X Window clipboard.
vim.opt.clipboard = 'unnamedplus'

-- Set a visual line at columns 80 and 120.
vim.opt.colorcolumn = '80,120'

-- Use case insensitive search, except when using capital letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Wrap lines that are too long.
vim.opt.wrap = true

-- Highlight the cursor's current column.
vim.opt.cursorcolumn = true

-- Keep the current visual mode selection after indenting.
vim.api.nvim_set_keymap('x', '<', '<gv', { desc = "Outdent" })
vim.api.nvim_set_keymap('x', '>', '>gv', { desc = "Indent" })

-- Quickly insert a dump() and place the cursor inside the function.
vim.api.nvim_set_keymap('n', '<leader>p', 'idump();exit;<ESC>7ha', {})

-- Format JSON and enable JSON syntax highlighting for empty buffers.
vim.api.nvim_set_keymap('n', '=j', ':%!jq .<CR>:set syntax=json<CR>', {})

-- Git blame the current line.
vim.api.nvim_set_keymap('n', '<C-b>', ':exec "!git blame -L " .. line(".") .. "," .. line(".") .. " %"<CR>', {})
