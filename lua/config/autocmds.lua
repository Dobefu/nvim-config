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

-- Set Go HTML template filetype for HTML files in Go and Hugo projects.
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.html',
  callback = function()
    local file_path = vim.api.nvim_buf_get_name(0)

    if file_path == '' then
      return
    end

    local file_dir = vim.fn.fnamemodify(file_path, ':h')
    local git_dir = vim.fn.finddir('.git', file_dir .. ';')

    if git_dir == '' then
      return
    end

    local git_dir_abs = vim.fn.fnamemodify(git_dir, ':p')
    local project_root = vim.fn.fnamemodify(git_dir_abs, ':h:h')

    local paths = {
      'go.mod',
      'go.sum',
      'go.work',
      'hugo.toml',
      'hugo.yaml',
      'hugo.yml',
      'hugo.json',
    }

    for _, path in ipairs(paths) do
      if vim.fn.filereadable(project_root .. '/' .. path) == 1 then
        vim.cmd('set filetype=gohtmltmpl')

        return
      end
    end
  end
})

-- Disable inlay hints globally.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function() vim.lsp.inlay_hint.enable(false) end
})
