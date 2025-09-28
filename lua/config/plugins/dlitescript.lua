local dlitescript = require('nvim-dlitescript')

dlitescript.setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  fold = {
    enable = false,
  },
  auto_install = true,
  lsp = {
    enable = true,
    cmd = {
      'sh',
      '-c',
      'cd ~/Projects/Web/Golang/DLiteScript && go run . lsp --stdio',
    },
    root_markers = { '.git' },
    settings = {},
  },
  lint = {
    enable = true,
    cmd = {
      'sh',
      '-c',
      'cd ~/Projects/Web/Golang/DLiteScript && go run . lint $1',
    },
    run_on_save = true,
    run_on_change = false,
  },
  format = {
    enable = true,
    cmd = {
      'sh',
      '-c',
      'cd ~/Projects/Web/Golang/DLiteScript && go run . fmt $1',
    },
  },
})
