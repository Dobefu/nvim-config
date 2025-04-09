-- Custom settings for C code.
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.{c,h,s,asm,cpp}',
  callback = function() vim.cmd('set cindent noexpandtab tabstop=4 shiftwidth=4') end
})

-- Set PHP filetype for non-standard file types.
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.{module,theme,install,test,inc,profile,view}',
  callback = function() vim.cmd('set filetype=php') end
})

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
