return {
   -- interesting, mb replace barbecue
   {
      'b0o/incline.nvim',
      enabled = false,
      event = 'VeryLazy',
      dependencies = {
         'nvim-tree/nvim-web-devicons',
      },
      config = function()
         local devicons = require 'nvim-web-devicons'
         require('incline').setup {
            window = {
               padding = 1,
               margin = {
                  horizontal = 0,
                  vertical = 0,
               },
            },
            render = function(props)
               local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
               if filename == '' then
                  filename = '[No Name]'
               end
               local ft_icon, ft_color = devicons.get_icon_color(filename)

               local function get_git_diff()
                  local icons = { removed = ' ', changed = ' ', added = ' ' }
                  local signs = vim.b[props.buf].gitsigns_status_dict
                  local labels = {}
                  if signs == nil then
                     return labels
                  end
                  for name, icon in pairs(icons) do
                     if tonumber(signs[name]) and signs[name] > 0 then
                        table.insert(labels, { icon .. signs[name] .. ' ', group = 'WinBarDiff' .. name })
                     end
                  end
                  -- if #labels > 0 then
                  --    table.insert(labels, { '| ' })
                  -- end
                  return labels
               end

               return {
                  { get_git_diff() },
                  { (ft_icon or '') .. ' ', guifg = ft_color,                                            guibg = 'none' },
                  { filename,               gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
               }
            end,
         }
      end,
   },
   {
      'barrett-ruth/live-server.nvim',
      build = 'npm add -g live-server',
      cmd = { 'LiveServerStart', 'LiveServerStop' },
      config = true,
   },
   -- interesting, but oil better??
   {
      'echasnovski/mini.files',
      version = '*',
      keys = {
         {
            '<leader>mf',
            function()
               require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
            end,
            desc = 'Toggle mini.files',
         },
      },
      opts = {
         default_file_explorer = false,
         mappings = {
            go_in = '<Right>',
            go_out = '<Left>',
         },
      },
   },
   {
      'ibhagwan/fzf-lua',
      -- optional for icon suppor
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         -- calling `setup` is optional for customization
         -- TODO: git_icons = true
         require('fzf-lua').setup {}
      end,
   },
   {
      'potamides/pantran.nvim',
      keys = {
         { '<leader>trr', desc = 'Translate line' },
         { '<leader>tr',  desc = 'Translate selection', mode = { 'x', 'v' } },
      },
      config = function()
         local pantran = require 'pantran'
         pantran.setup {
            default_engine = 'google',
            engines = {
               google = {
                  default_source = 'auto',
                  -- not works
                  default_target = 'ru',
                  fallback = {
                     -- works
                     default_target = 'ru',
                  },
               },
            },
         }
         local opts = { noremap = true, silent = true, expr = true }
         opts.desc = 'Translate line'
         vim.keymap.set('n', '<leader>trr', function()
            return pantran.motion_translate() .. '_'
         end, opts)
         opts.desc = 'Translate selection'
         vim.keymap.set('x', '<leader>tr', pantran.motion_translate, opts)
      end,
   },
}
