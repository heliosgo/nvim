return {
  'akinsho/nvim-bufferline.lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }
  },
  config = function()
    require('bufferline').setup({
      options = {
        modified_icon = '✥',
        buffer_close_icon = '',
        always_show_bufferline = true,
      },
    })
  end
}
