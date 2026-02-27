local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local luasnip = require('luasnip')
local telescope = require('telescope.builtin')
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local ft_lsp_group = vim.api.nvim_create_augroup(
  'ft_lsp_group',
  { clear = true }
)

local capabilities = require('cmp_nvim_lsp')
capabilities.default_capabilities()

mason.setup()
mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    'bashls',
    'css_variables',
    'cssls',
    'diagnosticls',
    'docker_compose_language_service',
    'dockerls',
    'eslint',
    'golangci_lint_ls',
    'graphql',
    'html',
    'jsonls',
    'lua_ls',
    'mdx_analyzer',
    'phpactor',
    'svelte',
    'tailwindcss',
    'ts_ls',
    'twiggy_language_server',
    'vimls',
    'vue_ls',
    'yamlls',
  }
})

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

vim.g.markdown_fenced_languages = {
  'ts=typescript'
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable('gopls')
vim.lsp.config('gopls', {
  filetypes = {
    'go',
    'gomod',
    'gowork',
    'gohtml',
    'gotmpl',
    'go.html',
    'go.tmpl',
  },
})

vim.lsp.config('ts_ls', {
  single_file_support = true,
  root_markers = { 'jsconfig.json', 'tsconfig.json', 'package.json', '.git' },
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vim.fn.expand(
          '$MASON/packages/vue-language-server/node_modules/@vue/language-server'
        ),
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'none',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
    },
  },
})

vim.lsp.enable('vue_ls')
vim.lsp.config('vue_ls', {
  filetypes = {
    'typescript',
    'typescriptreact',
    'vue',
  },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
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

vim.lsp.enable('tailwindcss')

vim.lsp.enable('vimls')

vim.lsp.enable('jsonls')

vim.lsp.enable('phpactor')
vim.lsp.config('phpactor', {
  root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
  workspace_required = true,
  init_options = {
    ['language_server_phpstan.enabled'] = true,
    ['language_server_phpstan.config'] = '%project_root%/phpstan.neon',
    ['language_server_psalm.enabled'] = false,
    ['language_server_highlight.enabled'] = true,
    ['php_code_sniffer.enabled'] = false,
    ['prophecy.enabled'] = false,
  }
})

vim.lsp.enable('twiggy_language_server')

vim.lsp.enable('html')

vim.lsp.enable('cssls')
vim.lsp.config('cssls', {
  capabilities = lsp_capabilities,
  init_options = {
    provideFormatter = false,
  },
})

vim.lsp.enable('css_variables')

vim.lsp.enable('diagnosticls')

vim.lsp.enable('dockerls')

vim.lsp.enable('docker_compose_language_service')

vim.lsp.enable('sqlls')

vim.lsp.enable('bashls')

vim.lsp.enable('eslint')
vim.lsp.config('eslint', {
  single_file_support = true,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
    'json',
  }
})

vim.lsp.enable('golangci_lint_ls')
vim.lsp.config('golangci_lint_ls', {
  init_options = {
    command = {
      'golangci-lint',
      'run',
      '--output.json.path=stdout',
      '--show-stats=false',
    },
  },
})

vim.lsp.enable('svelte')

vim.lsp.enable('mdx_analyzer')

vim.lsp.enable('java_language_server')

vim.lsp.enable('gradle_ls')

vim.lsp.enable('jdtls')

vim.lsp.enable('yamlls')

-- vim.lsp.enable('denols')
-- vim.lsp.config('denols', {
--   filetypes = { 'javascript', 'typescript' },
--   root_markers = { 'deno.json', 'deno.jsonc' },
-- })

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config') and
          (
            vim.uv.fs_stat(path .. '/.luarc.json') or
            vim.uv.fs_stat(path .. '/.luarc.jsonc')
          )
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend(
      'force',
      client.config.settings.Lua,
      {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
  end,
  settings = {
    Lua = {}
  }
})

vim.keymap.set(
  'n',
  'gd',
  function() telescope.lsp_definitions({ jump_type = 'tab' }) end,
  { silent = true, noremap = true }
)

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
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { 'docker-compose.yaml', 'docker-compose.yml' },
  group = ft_lsp_group,
  desc = 'Fix the issue where the LSP does not start with docker-compose.',
  callback = function()
    vim.opt.filetype = 'yaml.docker-compose'
  end
})

-- Go to the next or previous LSP issue.
vim.keymap.set(
  'n',
  '<leader>g',
  function() vim.diagnostic.jump({ count = 1 }) end,
  { desc = 'Go to next LSP issue' }
)

vim.keymap.set(
  'n',
  '<leader>G',
  function() vim.diagnostic.jump({ count = -1 }) end,
  { desc = 'Go to previous LSP issue' }
)

vim.keymap.set(
  'n',
  '<leader>ca',
  function()
    vim.lsp.buf.code_action({ apply = true })
  end,
  { desc = 'Run code action' }
)
