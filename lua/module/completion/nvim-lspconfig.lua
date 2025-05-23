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
    'jsonc',
    'css',
    'html',
    'swift',
    'python',
    'java',
  },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'mfussenegger/nvim-jdtls' },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.diagnostic.config({
      -- signs = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
          [vim.diagnostic.severity.HINT] = '󰌵 ',
        },
      },
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
      root_dir = function()
        return vim.fn.getcwd()
      end,
      cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
      settings = {
        ['rust-analyzer'] = {
          reportMissingImports = true,
          imports = {
            granularity = {
              group = 'module',
            },
            prefix = 'self',
          },
          cargo = {
            allFeatures = true,
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

    lspconfig.pyright.setup({})

    -- java
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        local config = {
          cmd = { 'jdtls' },
          root_dir = vim.fs.dirname(
            vim.fs.find(
              { 'gradlew', '.git', 'mvnw', 'pom.xml' },
              { upward = true }
            )[1]
          ),
        }
        require('jdtls').start_or_attach(config)
      end,
    })

    local ccapabilities = vim.lsp.protocol.make_client_capabilities()
    ccapabilities.offsetEncoding = { 'utf-16' }
    lspconfig.clangd.setup({
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
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
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'typescript-language-server', '--stdio' },
      settings = {
        diagnostics = { ignoredCodes = { 6133, 80001 } },
        completions = { completeFunctionCalls = true },
      },
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })

    lspconfig.jsonls.setup({
      capabilities = ccapabilities,
    })

    lspconfig.cssls.setup({
      capabilities = ccapabilities,
    })

    lspconfig.html.setup({
      capabilities = ccapabilities,
    })

    lspconfig.sourcekit.setup({
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    })
  end,
}
