local noice = require("noice")

noice.setup({
  cmdline = {
    view = "cmdline",
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
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
    { filter = { event = "notify", find = "SonarQube language server is ready" }, view = "mini" },
    { filter = { event = "msg_show", kind = "", find = "written" },               view = "mini" },
  },
})
