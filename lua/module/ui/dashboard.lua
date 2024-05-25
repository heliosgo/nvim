return {
  'heliosgo/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local global = require('core.global')
    require('dashboard').setup({
      theme = 'hyper',
      preview = {
        command = 'cat | lolcat -F 0.3',
        file_path = global.vim_path .. '/static/neovim.cat',
        file_height = 12,
        file_width = 40,
      },
      config = {
        shortcut = {
          {
            desc = 'Talk is cheap. Show me the code.',
          },
        },
      },
    })
  end,
}
