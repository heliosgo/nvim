return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufEnter',
  ft = {
    'go',
    'lua',
    'rust',
    'c',
    'cpp',
    'sh',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'golines' },
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
      },
      format_after_save = {
        lsp_fallback = true,
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      formatters = {
        golines = {
          command = 'golines',
          args = { '--base-formatter=gofumpt' },
        },
      },
    })
  end,
}
