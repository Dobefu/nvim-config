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

-- Disable inlay hints globally.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function() vim.lsp.inlay_hint.enable(false) end
})
