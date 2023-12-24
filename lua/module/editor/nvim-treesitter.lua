return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = 'BufRead',
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.api.nvim_command("TSUpdate")
    end
  end,
  config = function()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'rust', 'go' },
      highlight = {
        enable = true,
      },
    })
  end
}
