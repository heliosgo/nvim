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
    'markdown',
    'astro',
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
    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = '/usr/local/bin/vue-language-server',
      languages = { 'vue' },
      configNamespace = 'typescript',
    }
    local function get_astro_plugin_path()
      local root = vim.fs.root(
        0,
        { '.git', 'package.json', 'astro.config.mjs' }
      ) or vim.fn.getcwd() -- fallback 到 cwd

      return root .. '/node_modules/@astrojs/ts-plugin'
    end
    local astro_plugin = {
      name = '@astrojs/ts-plugin',
      location = get_astro_plugin_path(),
      languages = { 'astro' },
      configNamespace = 'typescript',
    }
    local tsserver_filetypes = {
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'vue',
      'astro',
    }
    vim.lsp.config('vtsls', {
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              vue_plugin,
              astro_plugin,
            },
          },
        },
      },
      filetypes = tsserver_filetypes,
    })
    vim.lsp.config('vue_ls', {
      on_init = function(client)
        client.handlers['tsserver/request'] = function(_, result, context)
          local ts_clients =
            vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
          local vtsls_clients =
            vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
          local clients = {}

          vim.list_extend(clients, ts_clients)
          vim.list_extend(clients, vtsls_clients)

          if #clients == 0 then
            vim.notify(
              'Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.',
              vim.log.levels.ERROR
            )
            return
          end
          local ts_client = clients[1]

          local param = unpack(result)
          local id, command, payload = unpack(param)
          ts_client:exec_cmd({
            title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
            command = 'typescript.tsserverRequest',
            arguments = {
              command,
              payload,
            },
          }, { bufnr = context.bufnr }, function(_, r)
            local response = r and r.body
            -- TODO: handle error or response nil here, e.g. logging
            -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
            local response_data = { { id, response } }

            ---@diagnostic disable-next-line: param-type-mismatch
            client:notify('tsserver/response', response_data)
          end)
        end
      end,
    })
    vim.lsp.enable({ 'vtsls', 'vue_ls' })

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

    vim.lsp.enable('jsonls')

    vim.lsp.enable('cssls')

    vim.lsp.enable('html')

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

    --vim.lsp.enable('markdown_oxide')
  end,
}
