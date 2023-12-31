return {
  'L3MON4D3/LuaSnip',
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
  end,
}
