return {
  'neovim/nvim-lspconfig',
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
  },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    local signs = {
      Error = ' ',
      Warn = ' ',
      Info = ' ',
      Hint = 'ﴞ ',
    }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    vim.diagnostic.config({
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      virtual_text = {
        source = true,
      },
    })

    -- backend
    lspconfig.gopls.setup({
      cmd = { 'gopls', '--remote=auto' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          usePlaceholders = true,
          buildFlags = { '-tags=integration' },
        },
      },
    })

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            enable = true,
          },
          runtime = { version = 'LuaJIT' },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          imports = {
            granularity = {
              group = 'module',
            },
            prefix = 'self',
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
          typing = {
            autoClosingAngleBrackets = {
              enable = true,
            },
          },
        },
      },
    })

    local ccapabilities = vim.lsp.protocol.make_client_capabilities()
    ccapabilities.offsetEncoding = { 'utf-16' }
    lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = ccapabilities,
      cmd = {
        'clangd',
        '--background-index',
        '--suggest-missing-includes',
        '--clang-tidy',
        '--header-insertion=iwyu',
      },
    })

    -- frontend
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.eslint.setup({
      filetypes = { 'javascriptreact', 'typescriptreact' },
      on_attach = function(client, bufnr)
        on_attach(client)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })
  end,
}
