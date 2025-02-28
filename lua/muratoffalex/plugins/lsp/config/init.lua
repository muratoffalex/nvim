local LSP = require 'muratoffalex.plugins.lsp.config.servers'

local function client_capabilities()
  local base_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()
  local custom_capabilities = {
    workspace = {
      -- https://www.reddit.com/r/neovim/comments/1gdkrtn/i_want_to_use_neovim_but_the_lspintellisense_just/
      -- disable if performance is an issue
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
  }

  return vim.tbl_deep_extend('force', base_capabilities, cmp_capabilities, custom_capabilities)
end

local M = {}

---@class LspServerConfig
---@field enabled boolean|nil
---@field auto_install boolean|nil
---@field lspconfig_settings lspconfig.Config|nil
---@field setup function|nil

---@return table<string, LspServerConfig>
M.lsp_servers = {
  [LSP.NIX_LS] = {
    auto_install = false,
  },
  [LSP.KULALA_LS] = {
    auto_install = false,
  },
  [LSP.VOLAR] = {
    lspconfig_settings = {
      settings = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      },
    },
  },
  [LSP.JSONLS] = {},
  [LSP.PYRIGHT] = {},
  [LSP.RUST_ANALYZER] = {},
  [LSP.HTML] = {
    lspconfig_settings = {
      filetypes = { 'html', 'twig', 'hbs' },
    },
  },
  [LSP.CSSLS] = {},
  [LSP.MARKSMAN] = {
    auto_install = false,
  },
  [LSP.TAILWINDCSS] = {
    lspconfig_settings = {
      filetypes = { 'html', 'twig', 'css', 'jsx', 'vue' },
      on_attach = function(_, _) end,
    },
  },
  [LSP.GOPLS] = {
    lspconfig_settings = {
      root_dir = function(filename, _)
        local util = require 'lspconfig.util'
        return util.find_git_ancestor(filename)
          or util.root_pattern '.jj'(filename)
          or util.root_pattern '.hg'(filename)
          or util.root_pattern 'go.mod'(filename)
      end,
      -- ref: https://github.com/LazyVim/LazyVim/blob/ecfaed3cc1cbe3013f1201594adde2ea0022c455/lua/lazyvim/plugins/extras/lang/go.lua#L13
      settings = {
        formatting_enabled = false,
        codelens_enabled = true,
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            fieldalignment = true,
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules', '-.jj' },
          semanticTokens = true,
        },
      },
    },
  },
  [LSP.INTELEPHENSE] = {
    lspconfig_settings = {
      settings = {
        formatting_enabled = false,
        codelens_enabled = true,
        intelephense = {
          codeLens = {
            implementations = {
              enable = true,
            },
            overrides = {
              enable = true,
            },
            parent = {
              enable = true,
            },
            references = {
              enable = true,
            },
            usages = {
              enable = true,
            },
          },
        },
      },
    },
  },
  -- only for php 8.0+
  -- phpactor = {},
  -- kotlin_language_server = {},
  [LSP.TS_LS] = {
    lspconfig_settings = {
      settings = {
        formatting_enabled = false,
      },
    },
  },
  [LSP.LUA_LS] = {
    lspconfig_settings = {
      settings = {
        formatting_enabled = false,
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    },
  },
  [LSP.SOURCEKIT] = {
    auto_install = false,
    lspconfig_settings = {
      filetypes = { 'swift', 'objective-c', 'objective-cpp' },
      autostart = false,
      cmd = { vim.trim(vim.fn.system 'xcrun -f sourcekit-lsp') },
      ---@return string|nil
      root_dir = function(filename, _)
        local util = require 'lspconfig.util'
        return util.root_pattern 'buildServer.json'(filename)
          or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
          or util.find_git_ancestor(filename)
          or util.root_pattern 'Package.swift'(filename)
      end,
      -- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
      capabilities = vim.tbl_deep_extend('force', client_capabilities(), {
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = true },
        },
      }),
    },
    setup = function()
      local group = vim.api.nvim_create_augroup('SourcekitAutostart', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'LspDetach' }, {
        group = group,
        callback = function()
          if vim.bo.filetype == 'swift' and #(vim.lsp.get_clients { name = 'sourcekit' }) == 0 then
            vim.cmd 'LspStart'
          end
        end,
        desc = 'Start sourcekit on swift files if not already started (enter file or lsp crashed)',
      })
    end,
  },
  [LSP.CLANGD] = {
    lspconfig_settings = {
      filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
      -- https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
      cmd = {
        'clangd',
        '--offset-encoding=utf-16',
      },
    },
  },
}

---@return table<string, LspServerConfig>
M.active_lsp_servers = function()
  local active = {}
  for name, config in pairs(M.lsp_servers) do
    if config.enabled ~= false then
      active[name] = config
    end
  end
  return active
end

---@return string[]
M.ensure_installed = function()
  local servers = M.active_lsp_servers()
  local ensure = {}

  for server_name, config in pairs(servers) do
    if config.auto_install ~= false then
      table.insert(ensure, server_name)
    end
  end

  return ensure
end

M.format_lspconfig_settings = function(settings)
  local default_opts = {
    capabilities = M.client_capabilities,
    on_attach = M.on_attach,
  }
  local formatted = vim.tbl_deep_extend('force', default_opts, settings or {})

  return formatted
end

M.setup_lsp_servers = function(lspconfig)
  local servers = M.active_lsp_servers()
  for server_name, _ in pairs(servers) do
    local server = servers[server_name] or {}

    lspconfig[server_name].setup(M.format_lspconfig_settings(server.lspconfig_settings))

    if server.setup then
      server.setup()
    end
  end
end

M.client_capabilities = client_capabilities()

M.on_attach = function(client, bufnr)
  -- for inline diagnostic messages, use tiny-inline-diagnostic instead
  vim.diagnostic.config { virtual_text = false }

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- See `:help K` for why this keymap
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')

  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code actions')

  nmap('<leader>ni', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { nil })
  end, 'Toggle inlay hints')

  if client.config.settings.codelens_enabled then
    nmap('<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
  end
end

return M
