vim.api.nvim_create_user_command(
  'BrowserAutoreload',
  function()
    vim.api.nvim_create_autocmd('bufWritePost,FileWritePost', {
      pattern = '*',
      callback = function() vim.cmd('silent! !reload-browser') end
    })
  end,
  {}
)
