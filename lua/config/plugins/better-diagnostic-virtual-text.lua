local better_diagnostic_virtual_text = require('better-diagnostic-virtual-text')

better_diagnostic_virtual_text.setup({
  ui = {
    wrap_line_after = false,
    left_kept_space = 3,
    right_kept_space = 3,
    arrow = '  ',
    up_arrow = '  ',
    down_arrow = '  ',
    above = false,
  },
  priority = 2003,
  inline = true,
})
