vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
  end,
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
  callback = function()
    vim.cmd('syntax off')
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'NvimTree_*',
  callback = function()
    local layout = vim.api.nvim_call_function('winlayout', {})
    if
      layout[1] == 'leaf'
      and vim.api.nvim_get_option_value(
        'filetype',
        { buf = vim.api.nvim_win_get_buf(layout[2]) }
      ) == 'NvimTree'
      and layout[3] == nil
    then
      vim.api.nvim_command([[confirm quit]])
    end
  end,
})
