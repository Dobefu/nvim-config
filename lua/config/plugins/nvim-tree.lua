local nvim_tree = require('nvim-tree')
local nvim_tree_api = require('nvim-tree.api')

nvim_tree.setup({
  disable_netrw = true,
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    centralize_selection = true,
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "name",
  },
  diagnostics = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = function()
    vim.keymap.set('n', '<enter>', function() nvim_tree_api.node.open.tab() end, {})
  end
})

nvim_tree_api.events.subscribe(nvim_tree_api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
end)

vim.keymap.set(
  'n',
  '<C-t>',
  function() nvim_tree_api.tree.toggle({ find_file = true }) end,
  { desc = "Open Nvim Tree" }
)
