return {
   'yetone/avante.nvim',
   event = 'VeryLazy',
   lazy = false,
   version = false, -- set this if you want to always pull the latest change
   keys = {
      { '<leader>aa', '<cmd>AvanteAsk<cr>'},
      { '<leader>at', '<cmd>AvanteToggle<cr>'},
      { '<leader>ac', '<cmd>AvanteChat<cr>'},
      { '<leader>aC', '<cmd>AvanteClear<cr>'},
   },
   opts = {
      provider = 'copilot',
      copilot = {
         endpoint = 'https://api.githubcopilot.com',
         model = 'gpt-4o-2024-08-06',
         allow_insecure = true,           -- Allow insecure server connections
         timeout = 30000,                 -- Timeout in milliseconds
         temperature = 0,
         max_tokens = 4096,
      },
      openai = {
         endpoint = 'https://api.openai.com/v1',
         model = 'gpt-4o',
         timeout = 30000, -- Timeout in milliseconds
         temperature = 0,
         max_tokens = 4096,
         ['local'] = false,
      },
   },
   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
   build = 'make',
   dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua',      -- for providers='copilot'
      'MeanderingProgrammer/render-markdown.nvim',
   },
}
