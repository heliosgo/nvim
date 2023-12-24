return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  event = 'BufRead',
  config = function()
    require('ibl').setup({
      exclude = {
        filetypes = {
          'dashboard',
          'packer',
          'terminal',
          'help',
          'log',
          'markdown',
          'TelescopePrompt',
          'lspinfo',
          'toggleterm',
        },
      },
    })
  end
}
