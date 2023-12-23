return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine'
  },
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

    local copilot = {
      'copilot',
      symbols = {
        status = {
          icons = {
            enabled = '',
            disabled = '',
            warning = '',
            unknown = '',
          },
          hl = {
            enabled = '#41BC9C',
            disabled = '#6272A4',
            warning = '#FFB86C',
            unknown = '#FF5555',
          },
        },
        spinners = require('copilot-lualine.spinners').dots,
        spinner_color = '#6272A4',
      },
      show_colors = true,
      show_loading = true,
    }

    local function package_info()
      return require('package-info').get_status()
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
        lualine_x = { package_info, copilot, 'encoding', lsp_clients, 'filetype' },
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
