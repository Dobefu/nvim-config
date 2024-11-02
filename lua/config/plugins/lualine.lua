vim.opt.showmode = false

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#ffffff',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  green  = '#60aa50',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.green, bg = colors.grey },
    c = { fg = colors.white, bg = colors.grey },
  },

  insert = { a = { fg = colors.black, bg = colors.green } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.cyan, bg = colors.grey },
    b = { fg = colors.cyan, bg = colors.grey },
    c = { fg = colors.black, bg = colors.grey },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = bubbles_theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diagnostics'},
    lualine_c = { { 'filename', file_status = true, full_path = true, shorten = false, path = 2 } },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', file_status = true, full_path = true, shorten = false, path = 2 } },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        max_length = vim.o.columns,
        mode = 1,
        fmt = function(name, context)
          local buflist = vim.fn.tabpagebuflist(context.tabnr);
          local winnr = vim.fn.tabpagewinnr(context.tabnr);
          local bufnr = buflist[winnr];
          local mod = vim.fn.getbufvar(bufnr, '&mod');

          local filetype = vim.fn.getbufvar(bufnr, '&filetype');

          if filetype == 'javascript' then filetype = 'js' end
          if filetype == 'make' then filetype = 'makefile' end
          if filetype == 'typescript' then filetype = 'ts' end

          local icon, color = require("nvim-web-devicons").get_icon_color(name, filetype);

          if icon == nil then
            icon = '';
            color = colors.white;
          end

          return icon .. ' ' .. name .. (mod == 1 and ' ●' or '');
        end,
      },
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
