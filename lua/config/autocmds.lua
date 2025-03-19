-- auto-compile LaTeX.
vim.api.nvim_create_autocmd('bufWritePost', {
  pattern = '*.tex',
  callback = function() vim.cmd('!xelatex %') end
})

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

-- Close the initial empty buffer when opening a file.
vim.api.nvim_create_autocmd("BufNew", {
  callback = function(args)
    local buffers = vim.api.nvim_list_bufs()
    if #buffers <= 1 then return end

    local new_buf = args.buf

    local new_buf_type = vim.api.nvim_get_option_value("buftype", { buf = new_buf })
    if new_buf_type ~= "" then return end

    for _, buf in ipairs(buffers) do
      if buf ~= new_buf then
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_type = vim.api.nvim_get_option_value("buftype", { buf = buf })

        if buf_name == "" and buf_type == "" then
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

          if #lines <= 1 and (lines[1] == nil or lines[1] == "") then
            vim.schedule(function()
              pcall(vim.api.nvim_buf_delete, buf, { force = false })
            end)

            break
          end
        end
      end
    end
  end,
  group = vim.api.nvim_create_augroup("CloseInitialEmptyBuffer", { clear = true }),
  desc = "Close the initial empty buffer when opening a file",
})
