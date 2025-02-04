return {
  'dimaportenko/telescope-simulators.nvim',
  lazy = true,
  event = 'BufReadPre',
  keys = {
    { '<Leader>fq', '<cmd>Telescope simulators run<cr>' },
  },
  config = function()
    require('simulators').setup({
      android_emulator = false,
      apple_simulator = true,
    })
  end,
}
