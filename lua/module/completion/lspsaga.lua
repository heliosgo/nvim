return {
  'nvimdev/lspsaga.nvim',
  lazy = true,
  event = 'LspAttach',
  dependencies = { 'nvim-lspconfig' },
  keys = {
    { 'K', '<cmd>Lspsaga hover_doc<cr>' },
    { 'gh', '<cmd>Lspsaga finder<cr>' },
    { 'gd', '<cmd>Lspsaga peek_definition<cr>' },
    { 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>' },
    { 'gs', '<cmd>Lspsaga diagnostic_jump_next<cr>' },
    { 'gS', '<cmd>Lspsaga diagnostic_jump_prev<cr>' },
    {
      'ge',
      "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
    },
    {
      'gE',
      "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
    },
  },
  config = function()
    local saga = require('lspsaga')
    saga.setup({
      symbol_in_winbar = {
        enable = true,
      },
    })
  end,
}
