local codecompanion = require("codecompanion")

codecompanion.setup({
  display = {
    chat = {
      show_header_separator = false,
      window = {
        layout = "vertical",
        position = "left",
        relative = "editor",
      },
    },
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ",
      provider = "telescope",
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
  },
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
  },
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "http://127.0.0.1:1234",
          chat_url = "/v1/chat/completions",
        },
      })
    end,
  },
})

vim.api.nvim_set_keymap(
  'n',
  '<leader>a',
  '<Cmd>CodeCompanionActions<CR>',
  { noremap = true, silent = true, desc = "Open a CodeCompanion chat window" }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>c',
  '<Cmd>CodeCompanionChat Toggle<CR>',
  { noremap = true, silent = true, desc = "Toggle a CodeCompanion window" }
)
