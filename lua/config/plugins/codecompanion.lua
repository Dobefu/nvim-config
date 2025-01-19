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
    codellama = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "codellama",
        schema = {
          model = {
            default = "codellama:70b",
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
  '<Cmd>CodeCompanionChat<CR>',
  { noremap = true, silent = true, desc = "Open a CodeCompanion chat window" }
)
