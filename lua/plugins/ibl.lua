return {
   'lukas-reineke/indent-blankline.nvim',
   event = 'VeryLazy',
   ---@module "ibl"
   ---@type ibl.config
   opts = {
      indent = {
         char = '│',
         tab_char = '│',
      },
      scope = {
         enabled = true,
         show_start = false,
         show_end = false,
         -- mini.indentscope behavior
         include = {
            node_type = { ['*'] = { '*' } },
         },
      },
      exclude = {
         filetypes = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'lazyterm',
         },
      },
   },
   main = 'ibl',
}
