local go = require('go')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_nvim_lsp.default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

go.setup({
  run_in_floaterm = true,
  trouble = true,
  luasnip = true,
  lsp_cfg = {
    capabilities = capabilities,
  },
  golangci_lint = {
    default = 'standard',
    enable = {
      'govet',
      'ineffassign',
      'revive',
      'gosimple',
    },
  },
})
