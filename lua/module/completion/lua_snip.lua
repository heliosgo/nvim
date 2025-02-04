return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  lazy = true,
  event = 'BufReadPre',
  config = function()
    local ls = require('luasnip')
    local types = require('luasnip.util.types')
    ls.config.set_config({
      history = true,
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI',
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '<- choiceNode', 'Comment' } },
          },
        },
      },
    })

    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { '~/.config/nvim/lua/snippets' },
    })
  end,
}
