local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    css             = { 'prettierd' },
    go              = { 'goimports', 'gofmt' },
    gohtmltmpl      = {},
    graphql         = { 'prettierd' },
    groovy          = { 'npm-groovy-lint' },
    html            = { 'prettierd' },
    javascript      = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json            = { 'prettierd' },
    markdown        = { 'markdown-toc', 'prettierd' },
    typescript      = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    vue             = { 'prettierd' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
})

-- Format on save.
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})
