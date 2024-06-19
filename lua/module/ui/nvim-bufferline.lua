return {
  'akinsho/nvim-bufferline.lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require('bufferline').setup({
      options = {
        modified_icon = '✥',
        buffer_close_icon = '',
        always_show_bufferline = true,
        separator_style = { '', '' },
      },
      highlights = {
        fill = { bg = 'none' },
        background = { bg = 'none' },
        tab = { bg = 'none' },
        tab_selected = { bg = 'none' },
        tab_close = { bg = 'none' },
        tab_separator = { bg = 'none' },
        tab_separator_selected = { bg = 'none' },
        separator = { bg = 'none', fg = 'none' },
        separator_selected = { bg = 'none', fg = 'none' },
        indicator_visible = { bg = 'none' },
        indicator_selected = { bg = 'none' },
        buffer_visible = { bg = 'none' },
        buffer_selected = { bg = 'none' },
        close_button = { bg = 'none' },
        close_button_visible = { bg = 'none' },
        close_button_selected = { bg = 'none' },
        duplicate = { bg = 'none' },
        duplicate_visible = { bg = 'none' },
        duplicate_selected = { bg = 'none' },
        modified = { bg = 'none' },
        modified_visible = { bg = 'none' },
        modified_selected = { bg = 'none' },
        offset_separator = { bg = 'none', fg = 'none' },
        trunc_marker = { fg = 'none', bg = 'none' },
      },
    })
  end,
}
