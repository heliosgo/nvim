return {
  'mistweaverco/kulala.nvim',
  ft = 'http',
  keys = {
    { 'R', "<cmd>lua require('kulala').run()<cr>" },
  },
  config = function()
    require('kulala').setup({
      split_direction = 'horizontal',
      winbar = true,
    })
  end,
}
