return {
  'yetone/avante.nvim',
  version = false, -- set this if you want to always pull the latest change
  lazy = true,
  event = 'VeryLazy',
  keys = {
    { '<leader>aa', '<cmd>AvanteAsk<cr>' },
    { '<leader>at', '<cmd>AvanteToggle<cr>' },
    { '<leader>ac', '<cmd>AvanteChat<cr>' },
    { '<leader>aC', '<cmd>AvanteClear<cr>' },
    { '<leader>am', '<cmd>AvanteModels<cr>' },
  },
  opts = {
    provider = 'copilot',
    copilot = {
      model = 'claude-3.5-sonnet',
      allow_insecure = true,
    },
    vendors = {
      deepseek_v3 = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com',
        model = 'deepseek-chat',
        max_tokens = 4096,
      },
      deepseek_r1 = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com',
        model = 'deepseek-reasoner',
        max_tokens = 4096,
        disable_tools = true,
      },
    },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.icons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    'MeanderingProgrammer/render-markdown.nvim',
  },
}
