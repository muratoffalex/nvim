local M = {}

M.lsp_servers = require 'muratoffalex.plugins.lsp.config.servers'

M.active_lsp_servers = function()
   local active = {}
   for name, config in pairs(M.lsp_servers) do
      if config.enabled ~= false then
         active[name] = config
      end
   end
   return active
end

M.excluded_formatters = function()
   local servers = M.lsp_servers
   local excluded = {}

   for server_name, config in pairs(servers) do
      if config.disabled_formatter == true then
         table.insert(excluded, server_name)
      end
   end

   return excluded
end

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

M.exclude_auto_install = function()
   local servers = M.lsp_servers
   local excluded = {}

   for server_name, config in pairs(servers) do
      if config.auto_install == false then
         table.insert(excluded, server_name)
      end
   end

   return excluded
end

M.format = function(opts)
   local bufnr = type(opts) == 'number' and opts or type(opts) == 'table' and opts.buf or vim.api.nvim_get_current_buf()

   local function format_buffer()
      vim.lsp.buf.format {
         bufnr = bufnr,
         -- 2s because some tools are slow (ex. eslint)
         timeout_ms = 2000,
         filter = function(c)
            return not M.excluded_formatters()[c.name]
         end,
      }
   end

   -- Execute with error handling
   local ok, err = pcall(format_buffer)
   if not ok then
      vim.notify('Format failed: ' .. tostring(err), vim.log.levels.ERROR)
   end
end

M.client_capabilities = function()
   return vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
      require('cmp_nvim_lsp').default_capabilities(),
      {
         workspace = {
            didChangeWatchedFiles = { dynamicRegistration = false },
         },
      }
   )
end

M.on_attach = function(client, bufnr)
   -- for inline diagnostic messages, use tiny-inline-diagnostic instead
   vim.diagnostic.config { virtual_text = false }

   local nmap = function(keys, func, desc)
      if desc then
         desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
   end

   nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')

   -- Move to definition and center cursor on screen
   -- NOTE: <cmd>lua vim.lsp.buf.definition()<CR>zz for centering after
   nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
   nmap('gR', require('telescope.builtin').lsp_references, 'Goto References')
   nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
   nmap('gy', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

   -- See `:help K` for why this keymap
   -- TODO: in neovim 0.10 this is default keymap, mb remove
   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
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

   -- disable formatting
   -- client.resolved_capabilities.document_formatting = false
   -- Create a command `:Format` local to the LSP buffer
   vim.api.nvim_buf_create_user_command(bufnr, 'Format', M.format, { desc = 'Format current buffer with LSP' })
end

return M
