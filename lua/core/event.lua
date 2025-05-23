vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
  end,
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx,*.json,*.cc,*.h,*.jsx,*.js,*.css,*.wxml,*.wxss',
  callback = function()
    vim.cmd('syntax off')
  end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*.wxml',
  callback = function()
    vim.cmd('set filetype=xml')
  end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*.wxss',
  callback = function()
    vim.cmd('set filetype=css')
  end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*.eslintrc',
  callback = function()
    vim.cmd('set filetype=eslintrc')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result =
      vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding
            or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
})
