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
    'json',
    'jsonc',
    'css',
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
        json = { { 'prettierd', 'prettier' } },
        jsonc = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
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
