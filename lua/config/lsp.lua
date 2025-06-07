local mason = require("mason")
local lsp = require("lspconfig")
local luasnip = require("luasnip")
local telescope = require("telescope.builtin")
local cmp = require("cmp")
local sonarlint = require('sonarlint')
local ft_lsp_group = vim.api.nvim_create_augroup("ft_lsp_group", { clear = true })
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local capabilities = require("cmp_nvim_lsp")
capabilities.default_capabilities()

mason.setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "bashls",
    "cssls",
    "css_variables",
    "denols",
    "diagnosticls",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "golangci_lint_ls",
    "graphql",
    "html",
    "lua_ls",
    "mdx_analyzer",
    "svelte",
    "tailwindcss",
    "twiggy_language_server",
    "ts_ls",
    "vimls",
    "yamlls",
  }
})

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  }
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
lsp.gopls.setup({
  filetypes = {
    "go",
    "gomod",
    "gowork",
    "gohtml",
    "gotmpl",
    "gotexttmpl",
    "gohtmltmpl",
    "go.html",
    "go.tmpl",
  }
})
lsp.ts_ls.setup({
  root_dir = lsp.util.root_pattern("package.json"),
  single_file_support = false,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location =
            vim.fn.expand(
              "$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})
lsp.volar.setup({
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  root_dir = lsp.util.root_pattern(
    "vue.config.js",
    "vue.config.ts",
    "nuxt.config.js",
    "nuxt.config.ts"
  ),
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        parameterTypes = {
          enabled = true,
          suppressWhenArgumentMatchesName = true,
        },
        variableTypes = {
          enabled = true,
        },
      },
    },
  },
})
lsp.tailwindcss.setup({})
lsp.vimls.setup({})
lsp.intelephense.setup({
  settings = {
    intelephense = {
      format = {
        enable = false
      }
    }
  }
})
lsp.phpactor.setup({})
lsp.twiggy_language_server.setup({})
lsp.html.setup({})
lsp.cssls.setup({
  capabilities = lsp_capabilities,
  init_options = {
    provideFormatter = false,
  },
})
lsp.css_variables.setup({})
lsp.diagnosticls.setup({})
lsp.dockerls.setup({})
lsp.docker_compose_language_service.setup({})
lsp.sqlls.setup({})
lsp.bashls.setup({})
lsp.eslint.setup({
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro", "json" }
})
lsp.golangci_lint_ls.setup({})
lsp.svelte.setup({})
lsp.mdx_analyzer.setup({})
lsp.java_language_server.setup({})
lsp.gradle_ls.setup({})
lsp.jdtls.setup({})
lsp.yamlls.setup({})
lsp.denols.setup({
  root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
})
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

sonarlint.setup({
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

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Set Docker Compose syntax.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  group = ft_lsp_group,
  desc = "Fix the issue where the LSP does not start with docker-compose.",
  callback = function()
    vim.opt.filetype = "yaml.docker-compose"
  end
})

-- Go to the next or previous LSP issue.
vim.keymap.set("n", "<leader>g", vim.diagnostic.goto_next, { desc = "Go to next LSP issue" })
vim.keymap.set("n", "<leader>G", vim.diagnostic.goto_prev, { desc = "Go to previous LSP issue" })
