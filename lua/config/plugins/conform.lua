local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
    html = { "prettierd" },
    go = { "goimports", "gofmt" },
    twig = { "twig-cs-fixer" },
    markdown = { "markdown-toc", "prettierd" },
    groovy = { "npm-groovy-lint" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Format on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})
