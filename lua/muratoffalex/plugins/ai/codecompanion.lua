local slash_default_opts = {
  opts = {
    provider = 'snacks',
  },
}

local main_adapter = 'deepseek'

return {
  'olimorris/codecompanion.nvim',
  -- branch = 'feat/move-to-function-calling',
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
    {
      'Davidyz/VectorCode',
      version = '*',
      dependencies = 'nvim-lua/plenary.nvim',
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
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-3.5-sonnet',
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

    -- ref: https://github.com/olimorris/codecompanion.nvim/discussions/139#discussioncomment-11746762
    -- one more variant https://github.com/olimorris/codecompanion.nvim/discussions/1129
    local Path = require 'plenary.path'
    local data_path = vim.fn.stdpath 'data'
    local save_folder = Path:new(data_path, 'cc_saves')
    if not save_folder:exists() then
      save_folder:mkdir { parents = true }
    end

    vim.api.nvim_create_user_command('CodeCompanionLoad', function()
      local function start_picker()
        Snacks.picker.files {
          prompt_title = 'Saved CodeCompanion Chats',
          cwd = save_folder:absolute(),
        }
      end
      start_picker()
    end, {})

    -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
    vim.api.nvim_create_user_command('CodeCompanionSave', function(opts)
      local codecompanion = require 'codecompanion'
      local success, chat = pcall(function()
        return codecompanion.buf_get_chat(0)
      end)
      if not success or chat == nil then
        vim.notify('CodeCompanionSave should only be called from CodeCompanion chat buffers', vim.log.levels.ERROR)
        return
      end
      if #opts.fargs == 0 then
        vim.notify('CodeCompanionSave requires at least 1 arg to make a file name', vim.log.levels.ERROR)
      end
      local save_name = table.concat(opts.fargs, '-') .. '.md'
      local save_path = Path:new(save_folder, save_name)
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      save_path:write(table.concat(lines, '\n'), 'w')
    end, { nargs = '*' })
  end,
  init = function()
    require('muratoffalex.plugins.extensions.codecompanion.spinner-noice').init()
  end,
}
