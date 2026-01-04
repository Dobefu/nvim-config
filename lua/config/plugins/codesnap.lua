local codesnap = require('codesnap')

codesnap.setup({
  snapshot_config = {
    watermark = {
      content = '',
      font_family = 'Pacifico',
      color = '#ffffff',
    },
    background = '#535c68',
    code_config = {
      breadcrumbs = {
        enable = true,
        separator = '/',
        color = '#80838b',
        -- font_family = 'JetBrains Mono',
      },
      -- font_family = 'JetBrains Mono',
    },
    window = {
      margin = {
        x = 0,
        y = 0,
      },
    },
  },
  show_line_number = false,
  show_workspace = false,
  bg_x_padding = 0,
  bg_y_padding = 0,
  bg_padding = nil,
})

vim.api.nvim_create_user_command(
  'Screenshot',
  function()
    xpcall(
      function()
        codesnap.copy()
      end,
      function(err)
        print(err)
      end
    )
  end,
  { nargs = '*', range = '%' }
)
