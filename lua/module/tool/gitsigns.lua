return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'BufReadPre',
  keys = {
    { 'J', '<cmd>Gitsigns blame_line<cr>' },
  },
  config = function()
    require('gitsigns').setup({})
  end,
}
