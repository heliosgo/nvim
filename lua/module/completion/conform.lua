return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufEnter',
  ft = { 'go', 'lua', 'rust', 'c', 'cpp', 'sh' },
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'golines' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
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
