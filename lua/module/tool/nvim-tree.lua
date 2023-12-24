return {
  'kyazdani42/nvim-tree.lua',
  lazy = true,
  keys = {
    { '<Leader>e', '<cmd>NvimTreeToggle<cr>' }
  },
  dependences = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      disable_netrw = false,
      hijack_cursor = true,
      hijack_netrw = true,
      view = {
        width = 30,
        side = 'left',
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
      },
      renderer = {
        icons = {
          glyphs = {
            default = '',
            symlink = '',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              deleted = '',
              ignored = '',
              renamed = '',
              staged = '',
              unmerged = '',
              unstaged = '',
              untracked = '?',
            },
          },
        },
      },
    })
  end
}
