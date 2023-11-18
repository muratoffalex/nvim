return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local utils = require 'utils'

    -- lsp clients
    local function lsp_clients()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_active_clients { bufnr = bufnr }
      local clients_list = {}
      for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
      end
      return utils.dump(clients_list)
    end

    -- codeium info
    local function codeium()
      return '{…}' .. vim.fn['codeium#GetStatusString']()
    end

    require('lualine').setup {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = require('plugins.lualine.theme').theme(),
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { codeium, 'encoding', lsp_clients, 'filetype' },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {
        'neo-tree',
        'lazy',
        'trouble',
        'mason',
      },
    }
  end,
}
