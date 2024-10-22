return {
   -- now is bad
   {
      'saghen/blink.cmp',
      lazy = false, -- lazy loading handled internally
      enabled = false,
      dependencies = 'rafamadriz/friendly-snippets',

      -- use a release tag to download pre-built binaries
      version = 'v0.*',
      -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',

      opts = {
         highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
         },
         -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
         -- adjusts spacing to ensure icons are aligned
         nerd_font_variant = 'normal',

         -- experimental auto-brackets support
         -- accept = { auto_brackets = { enabled = true } }

         -- experimental signature help support
         -- trigger = { signature_help = { enabled = true } }
      },
   },
   {
      'monkoose/neocodeium',
      enabled = false,
      event = 'VeryLazy',
      config = function()
         local neocodeium = require 'neocodeium'
         neocodeium.setup()
         vim.keymap.set('i', '<A-g>', function()
            require('neocodeium').accept()
         end)
         vim.keymap.set('i', '<A-w>', function()
            require('neocodeium').accept_word()
         end)
         vim.keymap.set('i', '<A-a>', function()
            require('neocodeium').accept_line()
         end)
         vim.keymap.set('i', '<A-.>', function()
            require('neocodeium').cycle_or_complete()
         end)
         vim.keymap.set('i', '<A-,>', function()
            require('neocodeium').cycle_or_complete(-1)
         end)
         vim.keymap.set('i', '<A-x>', function()
            require('neocodeium').clear()
         end)
         vim.keymap.set('n', '<leader>cC', '<cmd>NeoCodeium chat<cr>',
            { expr = true, desc = 'Codeium chat', silent = true })
      end,
   },
   {
      'Exafunction/codeium.nvim',
      event = 'VeryLazy',
      enabled = false,
      dependencies = {
         'nvim-lua/plenary.nvim',
         'hrsh7th/nvim-cmp',
      },
      config = function()
         require('codeium').setup {
            enable_chat = true,
         }
      end,
   },
   -- interesting, mb replace barbecue
   {
      'b0o/incline.nvim',
      enabled = true,
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

               local buf_modified = vim.api.nvim_get_option_value('modified', { buf = props.buf })
               local ft_icon, ft_color = devicons.get_icon_color(filename)
               if buf_modified then
                  ft_icon = '●'
                  ft_color = '#ff0000'
               end

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
