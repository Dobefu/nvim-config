vim.api.nvim_create_autocmd('bufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line('\'"')
    local column = vim.fn.col('\'"')

    if
        line > 1 and line <= vim.fn.line('$') and
        column > 1 and column <= vim.fn.col('$')
    then
      vim.api.nvim_win_set_cursor(0, { line, column })
    end
  end
})
