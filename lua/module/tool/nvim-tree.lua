return {
  'kyazdani42/nvim-tree.lua',
  lazy = true,
  keys = {
    { '<Leader>e', '<cmd>NvimTreeToggle<cr>' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      hijack_cursor = true,
      filters = {
        git_ignored = false,
      },
      renderer = {
        icons = {
          glyphs = {
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
  end,
}
