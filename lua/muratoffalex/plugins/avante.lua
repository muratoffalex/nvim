return {
  'yetone/avante.nvim',
  version = false, -- set this if you want to always pull the latest change
  lazy = true,
  event = 'VeryLazy',
  -- event = {
  --   {
  --     event = 'ModeChanged',
  --     pattern = { '*:[vV\x16]*' }, -- when enter in visual mode
  --   },
  -- },
  keys = {
    { '<leader>aa', '<cmd>AvanteAsk<cr>' },
    { '<leader>at', '<cmd>AvanteToggle<cr>' },
    { '<leader>ac', '<cmd>AvanteChat<cr>' },
    { '<leader>aC', '<cmd>AvanteClear<cr>' },
  },
  opts = {
    provider = 'copilot',
    copilot = {
      endpoint = 'https://api.githubcopilot.com',
      model = 'claude-3.5-sonnet',
      allow_insecure = true, -- Allow insecure server connections
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
  },
  build = 'make',
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.icons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    'MeanderingProgrammer/render-markdown.nvim',
  },
}
