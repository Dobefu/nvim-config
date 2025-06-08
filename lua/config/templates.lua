-- Use a template for new Vue files.
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.vue',
  callback = function() vim.cmd('0r ~/.config/nvim/templates/skeleton.vue') end
})

-- Use a template for new TSX files.
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.tsx',
  callback = function() vim.cmd('0r ~/.config/nvim/templates/skeleton.tsx') end
})

-- Use a template for new HTML files.
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.html',
  callback = function() vim.cmd('0r ~/.config/nvim/templates/skeleton.html') end
})

-- Use a template for new shell scripts.
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.sh',
  callback = function() vim.cmd('0r ~/.config/nvim/templates/skeleton.sh') end
})
