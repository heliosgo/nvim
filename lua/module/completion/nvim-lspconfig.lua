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
    'xml',
  },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'mfussenegger/nvim-jdtls' },
  },
  config = function()
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
    vim.lsp.config('gopls', {
      cmd = { 'gopls', '--remote=auto' },
      filetypes = { 'go' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          usePlaceholders = true,
          buildFlags = { '-tags=integration' },
        },
      },
    })
    vim.lsp.enable('gopls')

    vim.lsp.config('lua_ls', {
      on_attach = on_attach,
      filetypes = { 'lua' },
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
    vim.lsp.enable('lua_ls')

    vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      on_attach = on_attach,
      root_markers = { 'Cargo.toml', '.git' },
      filetypes = { 'rust' },
      single_file_support = true,
      cmd = { 'rust-analyzer' },
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
      before_init = function(init_params, config)
        if config.settings and config.settings['rust-analyzer'] then
          init_params.initializationOptions = config.settings['rust-analyzer']
        end
      end,
    })
    vim.lsp.enable('rust_analyzer')

    vim.lsp.config('pyright', {
      filetypes = { 'python' },
    })
    vim.lsp.enable('pyright')

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
    vim.lsp.config('clangd', {
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
    vim.lsp.enable('clangd')

    -- frontend
    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'typescript-language-server', '--stdio' },
      settings = {
        diagnostics = { ignoredCodes = { 6133, 80001 } },
        completions = { completeFunctionCalls = true },
      },
    })
    vim.lsp.enable('ts_ls')

    vim.lsp.config('eslint', {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })
    vim.lsp.enable('eslint')

    vim.lsp.config('jsonls', {
      capabilities = ccapabilities,
    })
    vim.lsp.enable('jsonls')

    vim.lsp.config('cssls', {
      capabilities = ccapabilities,
    })
    vim.lsp.enable('cssls')

    vim.lsp.config('html', {
      capabilities = ccapabilities,
    })
    vim.lsp.enable('html')

    vim.lsp.config('lemminx', {
      capabilities = ccapabilities,
    })
    vim.lsp.enable('lemminx')

    vim.lsp.config('sourcekit', {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    })
    vim.lsp.enable('sourcekit')
  end,
}
