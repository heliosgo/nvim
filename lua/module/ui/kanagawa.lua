return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      terminalColors = false,
      colors = {
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function()
        return {
          FloatBorder = { bg = 'none' },
          NormalFloat = { bg = 'none' },
        }
      end,
    })

    vim.cmd([[colorscheme kanagawa]])
  end,
}
