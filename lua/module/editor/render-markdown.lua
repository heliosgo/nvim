return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } }, -- enable completion for markdown files
  },
  config = function()
    require('render-markdown').setup({
      code = {
        style = 'language',
        language_border = '',
        language_icon = false,
      },
      heading = { backgrounds = {} },
      overrides = {
        buftype = {
          nofile = {
            anti_conceal = { enabled = false },
          },
        },
        preview = {
          anti_conceal = { enabled = false },
        },
      },
    })
  end,
}
