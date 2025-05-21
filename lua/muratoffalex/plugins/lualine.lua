-- ref: https://github.com/jessevdp/personal.nvim/blob/1aa011927be1ccc515477f6d08c9a206c8e163e5/lua/plugins/statusline.lua#L27-L43
local mode = {
  'mode',
  fmt = function(s)
    local mode_map = {
      ['NORMAL'] = 'N',
      ['O-PENDING'] = 'N?',
      ['INSERT'] = 'I',
      ['VISUAL'] = 'V',
      ['V-BLOCK'] = 'VB',
      ['V-LINE'] = 'VL',
      ['V-REPLACE'] = 'VR',
      ['REPLACE'] = 'R',
      ['COMMAND'] = '!',
      ['SHELL'] = 'SH',
      ['TERMINAL'] = 'T',
      ['EX'] = 'X',
      ['S-BLOCK'] = 'SB',
      ['S-LINE'] = 'SL',
      ['SELECT'] = 'S',
      ['CONFIRM'] = 'Y?',
      ['MORE'] = 'M',
    }
    return mode_map[s] or s
  end,
}

local function avante_provider_name()
  return ' ' .. require('avante.config').provider
end

local function avante_model_name()
  local Providers = require 'avante.providers'
  local provider = require('avante.config').provider

  return Providers[provider].model
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
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

    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == '' then
        return ''
      end -- not recording
      return 'recording to ' .. reg
    end

    local function selectionCount()
      local starts = fn.line 'v'
      local ends = fn.line '.'
      local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
      return tostring(lines) .. 'L:' .. tostring(fn.wordcount().visual_chars) .. 'C'
    end

    local mcp = require 'mcphub.extensions.lualine'
    local update_status = mcp.update_status

    ---@diagnostic disable: duplicate-set-field
    function mcp:update_status()
      local status = update_status(self)
      -- remove extra space
      return status:sub(1, -4) .. status:sub(-2)
    end

    local codecompanion = require 'codecompanion'

    local function codecompanion_adapter_name()
      local chat = codecompanion.buf_get_chat(vim.api.nvim_get_current_buf())
      if not chat then
        return nil
      end

      return ' ' .. chat.adapter.formatted_name -- or just name
    end

    local function codecompanion_current_model_name()
      local chat = codecompanion.buf_get_chat(vim.api.nvim_get_current_buf())
      if not chat then
        return nil
      end

      return chat.settings.model
    end

    require('lualine').setup {
      options = {
        globalstatus = false,
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {
          'diagnostics',
        },
        lualine_c = {
          'pretty_path',
        },
        lualine_x = {
          isRecording,
          -- copilot,
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
        'quickfix',
        {
          filetypes = { 'AvanteInput' },
          sections = {
            lualine_a = { mode },
            lualine_b = { avante_provider_name },
            lualine_c = { avante_model_name },
            lualine_x = { mcp },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'Avante', 'AvanteSelectedFiles' },
          sections = {
            lualine_a = { mode },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
        },
        {
          filetypes = { 'codecompanion' },
          sections = {
            lualine_a = { mode },
            lualine_b = { codecompanion_adapter_name },
            lualine_c = { codecompanion_current_model_name },
            lualine_x = { mcp },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = { codecompanion_adapter_name },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { 'progress' },
            lualine_z = {},
          },
        },
      },
    }
  end,
}
