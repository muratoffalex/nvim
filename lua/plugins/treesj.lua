return {
   'Wansmer/treesj',
   dependencies = { 'nvim-treesitter/nvim-treesitter' },
   config = function()
      local treesj = require 'treesj'
      local lang_utils = require 'treesj.langs.utils'
      treesj.setup {
         langs = {
            swift = {
               array_literal = lang_utils.set_preset_for_dict {
                  split = {
                     last_separator = false,
                  },
                  join = {
                     space_in_brackets = false,
                  },
               },
               call_expression = lang_utils.set_preset_for_args {
                  target_nodes = { 'value_arguments' },
               },
               -- FIX: default values
               function_declaration = lang_utils.set_preset_for_args {
                  both = {
                     shrink_node = { from = '(', to = ')' },
                  },
               },
               -- FIX: 
               guard_statement = lang_utils.set_default_preset {
                  both = {
                     shrink_node = { from = 'guard', to = 'else' },
                  },
               },
               -- FIX: fix view of conjuction and disjunctioon
               conjunction_expression = lang_utils.set_default_preset {
                  join = {
                     space_in_brackets = true,
                  },
               },
               disjunction_expression = lang_utils.set_preset_for_args {
                  join = {
                     space_in_brackets = true,
                  },
               },
               init_declaration = lang_utils.set_preset_for_args {
                  both = {
                     shrink_node = { from = '(', to = ')' },
                  },
               },
               value_arguments = lang_utils.set_preset_for_args {
                  target_node = { 'value_argument' },
               },
               property_declaration = lang_utils.set_preset_for_args {
                  target_nodes = { 'array_literal', ['expr'] = 'call_expression' },
               },
            },
         },
      }
   end,
   keys = {
      {
         '<leader>cnt',
         function()
            require('treesj').toggle()
         end,
         desc = 'Toggle node under cursor (split/join)',
      },
      {
         '<leader>cns',
         function()
            require('treesj').split()
         end,
         desc = 'Split node under cursor',
      },
      {
         '<leader>cnj',
         function()
            require('treesj').join()
         end,
         desc = 'Join node under cursor',
      },
      {
         '<leader>cnS',
         function()
            require('treesj').split { split = { recursive = true } }
         end,
         desc = 'Split node under cursor (recursive)',
      },
      {
         '<leader>cnT',
         function()
            require('treesj').toggle { split = { recursive = true } }
         end,
         desc = 'Toggle node under cursor (split recursive/join)',
      },
   },
}
