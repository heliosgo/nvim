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
    'toml',
    'yaml',
    'python',
    'java',
    'astro',
    --    'sql',
  },
  config = function()
    local opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'golines' },
        rust = { 'rustfmt' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        astro = { 'prettier' },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        toml = { 'taplo' },
        yaml = { 'yamlfmt' },
        proto = { 'buf' },
        python = function(bufnr)
          if
            require('conform').get_formatter_info('ruff_format', bufnr).available
          then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        java = { 'google-java-format' },
        --        sql = { 'sqlfluff' },
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
    }
    opts.formatters['google-java-format'] = {
      command = 'google-java-format',
      args = { '-', '--aosp' },
    }
    require('conform').setup(opts)
  end,
}
