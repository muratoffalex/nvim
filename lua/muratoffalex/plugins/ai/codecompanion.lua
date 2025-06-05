local slash_default_opts = {
  opts = {
    provider = 'snacks',
  },
}

local main_adapter = 'openrouter'

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
    {
      'echasnovski/mini.diff', -- Inline and better diff over the default
      config = function()
        local diff = require 'mini.diff'
        diff.setup {
          -- Disabled by default
          source = diff.gen_source.none(),
        }
      end,
    },
    'ravitemer/codecompanion-history.nvim',
  },
  config = function(_, _)
    require('codecompanion').setup {
      extensions = {
        history = {
          enabled = true,
          opts = {
            picker = "snacks",
          },
        },
      },
      opts = {
        language = 'Russian',
      },
      display = {
        chat = {
          auto_scroll = false,
        },
        diff = {
          provider = 'mini_diff',
        },
      },
      adapters = {
        opts = {
          show_defaults = false,
        },
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "openrouter",
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-chat",
              },
            },
          })
        end,
        deepseek = function()
          return require('codecompanion.adapters').extend('deepseek', {
            schema = {
              model = {
                default = 'deepseek-chat',
              },
              temperature = {
                default = 0.0,
              },
              top_p = {
                default = nil,
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          slash_commands = {
            ['file'] = slash_default_opts,
            ['buffer'] = slash_default_opts,
            ['help'] = slash_default_opts,
            ['symbols'] = slash_default_opts,
          },
          adapter = main_adapter,
          tools = {
            ['mcp'] = {
              -- Prevent mcphub from loading before needed
              callback = function()
                return require 'mcphub.extensions.codecompanion'
              end,
              description = 'Call tools and resources from the MCP Servers',
            },
          },
        },
        inline = {
          adapter = main_adapter,
        },
        cmd = {
          adapter = main_adapter,
        },
      },
      prompt_library = {
        -- https://github.com/olimorris/codecompanion.nvim/blob/main/doc/RECIPES.md
        ['Code review'] = {
          strategy = 'chat',
          description = 'Code review',
          prompts = {
            {
              role = 'system',
              content = [[Analyze the code for:

### CODE QUALITY
* Function and variable naming (clarity and consistency)
* Code organization and structure
* Documentation and comments
* Consistent formatting and style

### RELIABILITY
* Error handling and edge cases
* Resource management
* Input validation

### MAINTAINABILITY
* Code duplication (but don't overdo it with DRY, some duplication is fine)
* Single responsibility principle
* Modularity and dependencies
* API design and interfaces
* Configuration management

### PERFORMANCE
* Algorithmic efficiency
* Resource usage
* Caching opportunities
* Memory management

### SECURITY
* Input sanitization
* Authentication/authorization
* Data validation
* Known vulnerability patterns

### TESTING
* Unit test coverage
* Integration test needs
* Edge case testing
* Error scenario coverage

### POSITIVE HIGHLIGHTS
* Note any well-implemented patterns
* Highlight good practices found
* Commend effective solutions

Format findings as markdown and with:
- Issue: [description]
- Impact: [specific impact]
- Suggestion: [concrete improvement with code example/suggestion]
              ]],
            },
            {
              role = 'user',
              content = 'Please review provided code.\n' .. '#buffer #lsp',
            },
          },
        },
      },
    }

    vim.cmd [[cab cc CodeCompanion]]
  end,
  init = function()
    require('muratoffalex.plugins.extensions.codecompanion.spinner-noice').init()
  end,
}
