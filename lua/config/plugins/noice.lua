local noice = require('noice')

noice.setup({
  cmdline = {
    view = 'cmdline',
  },
  messages = {
    enabled = true,
    view = 'mini',
    view_error = 'mini',
    view_warn = 'mini',
  },
  notify = {
    view = 'mini',
  },
  hover = {
    enabled = false,
  },
  all = {
    view = 'cmdline',
  },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = false,
    },
    signature = {
      enabled = false,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
  routes = {
    { filter = { event = 'notify', find = 'SonarQube language server is ready' },    view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'written' },                  view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'Already at oldest change' }, view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'change; before' },           view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'changes; before' },          view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'change; after' },            view = 'mini' },
    { filter = { event = 'msg_show', kind = '', find = 'changes; after' },           view = 'mini' },
    { filter = { event = 'msg_show', kind = 'emsg', find = 'Pattern not found' },    view = 'mini' },
  },
})
