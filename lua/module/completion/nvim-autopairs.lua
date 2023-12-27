return {
  'windwp/nvim-autopairs',
  lazy = true,
  event = 'InsertEnter',
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup({
      check_ts = true,
      ts_config = {
        rust = {},
      },
    })
    local _, cmp = pcall(require, 'cmp')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({ map_char = { tex = '' } })
    )
  end,
}
