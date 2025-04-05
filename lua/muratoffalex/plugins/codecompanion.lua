return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
  },
  keys = {
    { '<localleader>aa', '<cmd>CodeCompanionActions<cr>', desc = 'Code Companion Actions', mode = { 'n', 'v' } },
    { '<localleader>at', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Code Companion Chat', mode = { 'n', 'v' } },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'Code Companion Add', mode = { 'v' } },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'folke/noice.nvim',
  },
  config = function(_, _)
    require('codecompanion').setup {
      opts = {
        language = 'Russian',
      },
      display = {
        chat = {
          auto_scroll = false,
        },
      },
      adapters = {
        deepseek = function()
          return require('codecompanion.adapters').extend('deepseek', {
            schema = {
              model = {
                default = 'deepseek-chat',
              },
              temperature = {
                default = 0.0,
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          slash_commands = {
            ['file'] = {
              opts = {
                provider = 'snacks',
              },
            },
            ['buffer'] = {
              opts = {
                provider = 'snacks',
              },
            },
          },
          adapter = 'deepseek',
        },
        inline = {
          adapter = 'deepseek',
        },
        cmd = {
          adapter = 'deepseek',
        },
      },
    }

    vim.cmd [[cab cc CodeCompanion]]
  end,
  init = function()
    require('muratoffalex.plugins.extensions.codecompanion.spinner-noice').init()
  end,
}
