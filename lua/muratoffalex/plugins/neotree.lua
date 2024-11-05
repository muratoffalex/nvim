local config = require 'muratoffalex.config'

return {
   'nvim-neo-tree/neo-tree.nvim',
   branch = 'v3.x',
   dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
   },
   lazy = true,
   cmd = { 'Neotree' },
   keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Neotree toggle' },
   },
   opts = {
      filesystem = {
         follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
         },
      },
      default_component_configs = {
         git_status = {
            symbols = {
               -- default unstaged icon not showing
               unstaged = config.icons.git.unstaged,
            },
         },
      },
   },
}
