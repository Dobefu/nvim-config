local nvim_tree = require('nvim-tree')
local nvim_tree_api = require('nvim-tree.api')

nvim_tree.setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
})

vim.keymap.set('n', '<leader>r', nvim_tree_api.tree.change_root_to_parent, {})
