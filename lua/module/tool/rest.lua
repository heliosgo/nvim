return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  dependencies = { 'luarocks.nvim' },
  keys = {
    { 'R', '<cmd>Rest run<cr>' },
  },
  config = function()
    require('rest-nvim').setup()
  end,
}
