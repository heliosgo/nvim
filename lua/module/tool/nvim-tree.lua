return {
  'kyazdani42/nvim-tree.lua',
  lazy = true,
  keys = {
    { '<Leader>w', '<cmd>NvimTreeToggle<cr>' },
    { '<Leader>e', '<cmd>NvimTreeFocus<cr>' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      view = {
        width = 29,
      },
      hijack_cursor = true,
      filters = {
        git_ignored = false,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
        },
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
