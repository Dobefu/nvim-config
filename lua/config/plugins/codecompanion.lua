local codecompanion = require("codecompanion")

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
  },
  adapters = {
    ollama_default = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "ollama_default",
        schema = {
          model = {
            default = "deepseek-r1:8b",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
})

-- Open the CodeCompanion chat.
vim.api.nvim_set_keymap(
  'n',
  '<leader>c',
  '<Cmd>CodeCompanionChat ollama_default<CR>',
  { noremap = true, silent = true, desc = "Open a CodeCompanion chat window" }
)
