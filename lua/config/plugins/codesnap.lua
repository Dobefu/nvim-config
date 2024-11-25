local codesnap = require('codesnap')

codesnap.setup({
	watermark = '',
	bg_color = "#535c68",
	has_breadcrumbs = true,
	has_line_number = false,
	show_workspace = true,
	bg_x_padding = 0,
	bg_y_padding = 0,
	bg_padding = nil,
})

vim.api.nvim_create_user_command('Screenshot', function()
	codesnap.copy_into_clipboard()
end, { range = true })
