local lsp = require("lspconfig");
local luasnip = require("luasnip");
local telescope = require("telescope.builtin");
local cmp = require("cmp");
local capabilities = require("cmp_nvim_lsp").default_capabilities()

completion_callback = require('completion').on_attach

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Languages: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

lsp.lua_ls.setup({})
lsp.gopls.setup({})

lsp.ts_ls.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand(
          '$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin'),
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
})

lsp.vuels.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("nuxt.config.ts"),
})

lsp.volar.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("nuxt.config.ts"),
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  init_options = {
    typescript = {
      tsdk = vim.fn.expand('$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib'),
    },
    preferences = {
      disableSuggestions = true,
    },
    languageFeatures = {
      implementation = true,
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      renameFileRefactoring = true,
      signatureHelp = true,
      codeAction = true,
      workspaceSymbol = true,
      diagnostics = true,
      semanticTokens = true,
      completion = {
        defaultTagNameCase = 'both',
        defaultAttrNameCase = 'kebabCase',
        getDocumentNameCasesRequest = false,
        getDocumentSelectionRequest = false,
      },
    },
  },
})

lsp.denols.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
})

lsp.tailwindcss.setup({
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = lsp.util.root_pattern("tailwind.config.js", "package.json"),
  settings = {},
})

vim.keymap.set("n", "gd", function() telescope.lsp_definitions({ jump_type = "tab" }) end,
  { silent = true, noremap = true })

vim.diagnostic.config({
  virtual_text = true,
})

local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'tailwindcss' },
  },
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/formatting') then
      -- Format the current buffer on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})
