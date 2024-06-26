return {
   'nvim-lualine/lualine.nvim',
   dependencies = {
      'AndreM222/copilot-lualine',
   },
   config = function()
      local utils = require 'utils'
      local fn = vim.fn
      local config = require 'config'

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
         color = { fg = "Gray" },
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

      -- local theme = require('plugins.lualine.theme').theme()
      -- local theme = config.theme

      -- FIXME: lualine theme not dynamic
      local theme = require 'lualine.themes.tokyonight'
      theme.normal.c.bg = nil

      require('lualine').setup {
         options = {
            -- TODO: toggle globalstatus to true
            -- when fix colors in diffent themes
            globalstatus = true,
            icons_enabled = true,
            theme = theme,
            component_separators = '|',
            section_separators = '',
         },
         sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { xcodebuild_build_status, xcodebuild_device, package_info, copilot, 'encoding', lsp_clients, 'filetype' },
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
