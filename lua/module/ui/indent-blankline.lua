return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  main = 'ibl',
  ft = {
    'javascript',
    'typescript',
    'html',
    'vue',
    'javascriptreact',
    'typescriptreact',
  },
  config = function()
    require('ibl').setup({
      indent = { highlight = None },
      whitespace = { remove_blankline_trail = false },
      scope = { enabled = false },
    })
    local hooks = require('ibl.hooks')
    hooks.register(hooks.type.ACTIVE, function(bufnr)
      return vim.tbl_contains({
        'html',
        'javascript',
        'typescript',
        'vue',
        'javascriptreact',
        'typescriptreact',
      }, vim.api.nvim_get_option_value('filetype', { buf = bufnr }))
    end)
  end,
}
