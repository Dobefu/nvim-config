require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
})

local lsp = require("lspconfig");
local luasnip = require("luasnip");
local telescope = require("telescope.builtin");
local cmp = require("cmp");
local capabilities = require("cmp_nvim_lsp")

capabilities.default_capabilities()

local sonar_language_server_path = require("mason-registry").get_package("sonarlint-language-server"):get_install_path()
local analyzers_path = sonar_language_server_path .. "/extension/analyzers"

require('sonarlint').setup({
  server = {
    cmd = {
      vim.fn.expand(sonar_language_server_path .. "/sonarlint-language-server"),
      "-stdio",
      "-analyzers",
      vim.fn.expand(analyzers_path .. "/sonarcfamily.jar"),
      vim.fn.expand(analyzers_path .. "/sonargo.jar"),
      vim.fn.expand(analyzers_path .. "/sonarhtml.jar"),
      vim.fn.expand(analyzers_path .. "/sonariac.jar"),
      vim.fn.expand(analyzers_path .. "/sonarjava.jar"),
      vim.fn.expand(analyzers_path .. "/sonarjavasymbolicexecution.jar"),
      vim.fn.expand(analyzers_path .. "/sonarjs.jar"),
      vim.fn.expand(analyzers_path .. "/sonarlineomnisharp.jar"),
      vim.fn.expand(analyzers_path .. "/sonarphp.jar"),
      vim.fn.expand(analyzers_path .. "/sonarpython.jar"),
      vim.fn.expand(analyzers_path .. "/sonartext.jar"),
      vim.fn.expand(analyzers_path .. "/sonarxml.jar"),
    },
  },
  filetypes = { "c", "c++", "c#", "css", "docker", "go", "html", "ipython", "java", "javascript", "kubernetes", "typescript", "python", "php", "terraform", "text", "xml", "yaml" },
  root_dir = lsp.util.root_pattern(".git"),
})

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

lsp.lua_ls.setup({
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})
lsp.gopls.setup({})
lsp.ts_ls.setup({})
lsp.vuels.setup({})
lsp.volar.setup({})
lsp.tailwindcss.setup({})
lsp.vimls.setup({})
lsp.phpactor.setup({})
lsp.twiggy_language_server.setup({})
lsp.html.setup({})
lsp.diagnosticls.setup({})

vim.keymap.set("n", "gd", function() telescope.lsp_definitions({ jump_type = "tab" }) end,
  { silent = true, noremap = true })

vim.diagnostic.config({
  virtual_text = true,
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
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
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'tailwindcss' },
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
