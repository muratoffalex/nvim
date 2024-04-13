return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine',
  },
  config = function()
    local utils = require 'utils'
    local fn = vim.fn

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

    local xcode_test_plan = { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = '#a6e3a1', bg = '#161622' } }
    local xcode_platform = {
      "vim.g.xcodebuild_platform == 'macOS' and '  macOS' or" ..
      " ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'",
      color = { fg = '#f9e2af', bg = '#161622' },
    }

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

    local function selectionCount()
      local starts = fn.line 'v'
      local ends = fn.line '.'
      local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
      return tostring(lines) .. 'L:' .. tostring(fn.wordcount().visual_chars) .. 'C'
    end

    require('lualine').setup {
      options = {
        globalstatus = true,
        icons_enabled = true,
        -- theme = require('plugins.lualine.theme').theme(),
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { xcode_test_plan, xcode_platform, package_info, copilot, 'encoding', lsp_clients, 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
          {
            selectionCount,
            cond = function()
              return fn.mode():find '[Vv]' ~= nil
            end,
          },
          'location',
        },
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
