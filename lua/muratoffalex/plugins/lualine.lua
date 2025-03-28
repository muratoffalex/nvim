return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine',
    'bwpge/lualine-pretty-path',
  },
  config = function()
    local utils = require 'muratoffalex.utils'
    local fn = vim.fn

    -- lsp clients
    local function lsp_clients()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients { bufnr = bufnr }
      local clients_list = {}
      for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
      end
      return utils.dump(clients_list, '·')
    end

    local function xcodebuild_device()
      if vim.g.xcodebuild_platform == 'macOS' then
        return ' macOS'
      end

      local deviceIcon = ''
      if vim.g.xcodebuild_platform:match 'watch' then
        deviceIcon = '􀟤'
      elseif vim.g.xcodebuild_platform:match 'tv' then
        deviceIcon = '􀡴 '
      elseif vim.g.xcodebuild_platform:match 'vision' then
        deviceIcon = '􁎖 '
      end

      if vim.g.xcodebuild_os then
        return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
      end

      return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
    end

    local xcodebuild_build_status = {
      "' ' .. vim.g.xcodebuild_last_status",
      color = { fg = 'Gray' },
    }

    local copilot = {
      'copilot',
      symbols = {
        status = {
          icons = {
            enabled = ' ',
            sleep = ' ',
            disabled = ' ',
            warning = ' ',
            unknown = ' ',
          },
          hl = {
            enabled = '#AEB7D0',
            sleep = '#41BC9C',
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

    local function selectionCount()
      local starts = fn.line 'v'
      local ends = fn.line '.'
      local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
      return tostring(lines) .. 'L:' .. tostring(fn.wordcount().visual_chars) .. 'C'
    end

    require('lualine').setup {
      options = {
        globalstatus = false,
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'diagnostics',
        },
        lualine_c = {
          'pretty_path'
        },
        lualine_x = {
          xcodebuild_build_status,
          xcodebuild_device,
          copilot,
          {
            lsp_clients,
            cond = function()
              return #vim.lsp.get_clients { bufnr = 0 } > 0
            end,
          },
          'encoding',
        },
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
        'symbols-outline',
      },
    }
  end,
}
