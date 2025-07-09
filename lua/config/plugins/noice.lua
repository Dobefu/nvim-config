local noice = require('noice')

noice.setup({
  cmdline = {
    enabled = true,
    view = 'cmdline',
  },
  messages = {
    enabled = true,
    view = 'mini',
    view_error = 'mini',
    view_warn = 'mini',
  },
  popupmenu = {
    enabled = true,
    backend = 'nui',
  },
  notify = {
    view = 'mini',
  },
  all = {
    view = 'cmdline',
  },
  lsp = {
    progress = {
      enabled = true,
      view = 'mini',
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    hover = {
      enabled = true,
    },
    signature = {
      enabled = true,
    },
    message = {
      enabled = true,
    },
  },
  health = {
    checker = false,
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})
