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

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

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
lsp.dockerls.setup({})
lsp.docker_compose_language_service.setup({})
lsp.sqlls.setup({})
lsp.bashls.setup({})
lsp.eslint.setup({})
lsp.lua_ls.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim'
        },
        disable = { "missing-fields" },
      },
      telemetry = { enable = false },
      workspace = {
        library = {
          "$VIMRUNTIME/lua/vim",
          "$HOME/.local/share/nvim/site/pack/packer/start",
        },
      },
    },
  },
})

require('sonarlint').setup({
  server = {
    cmd = {
      "sonarlint-language-server",
      "-stdio",
      "-analyzers",
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjavasymbolicexecution.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlineomnisharp.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonartext.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarxml.jar"),
    },
    settings = {
      sonarlint = {
        rules = {
          ["go:S1186"] = { level = "on" },
        },
      },
    },
  },
  filetypes = { "c", "cpp", "csharp", "css", "docker", "go", "html", "ipython", "java", "javascript", "kubernetes", "typescript", "python", "php", "terraform", "text", "xml", "yaml" },
})

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

local ft_lsp_group = vim.api.nvim_create_augroup("ft_lsp_group", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  group = ft_lsp_group,
  desc = "Fix the issue where the LSP does not start with docker-compose.",
  callback = function()
    vim.opt.filetype = "yaml.docker-compose"
  end
})
