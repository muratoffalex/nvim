local slash_default_opts = {
  opts = {
    provider = 'snacks',
  },
}

local main_adapter = 'openrouter'
local default_model = 'deepseek/deepseek-v4-flash'
local inline_model = 'deepseek/deepseek-v4-flash'
local streaming = true

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
      'nvim-mini/mini.diff', -- Inline and better diff over the default
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
            picker = 'snacks',
            title_generation_opts = {
              adapter = main_adapter,
              model = inline_model,
            },
          },
        },
      },
      opts = {
        language = 'Russian',
      },
      title_generation_opts = {
        adapter = main_adapter,
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
        acp = {
          opts = {
            show_presets = false,
          },
          claude_code = function()
            return require('codecompanion.adapters').extend('claude_code', {
              opts = {
                stream = streaming,
              },
            })
          end,
          kimi_cli = function()
            return require('codecompanion.adapters').extend('kimi_cli', {
              opts = {
                stream = streaming,
              },
            })
          end,
          opencode = function()
            return require('codecompanion.adapters').extend('opencode', {
              opts = {
                stream = streaming,
              },
            })
          end,
        },
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },
          openrouter = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = 'openrouter',
              env = {
                url = 'https://openrouter.ai/api',
                api_key = 'OPENROUTER_API_KEY',
              },
              opts = {
                stream = streaming,
              },
              schema = {
                model = {
                  default = default_model,
                },
              },
            })
          end,
          deepseek = function()
            return require('codecompanion.adapters').extend('deepseek', {
              name = 'deepseek',
              opts = {
                stream = streaming,
              },
              schema = {
                model = {
                  default = 'deepseek-reasoner',
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          slash_commands = {
            ['file'] = slash_default_opts,
            ['buffer'] = slash_default_opts,
            ['help'] = slash_default_opts,
            ['symbols'] = slash_default_opts,
          },
          adapter = main_adapter,
          opts = {
            system_prompt = [[
# Personal AGENTS.md

## Code Style

- Follow project code style
- Prefer functional programming over OOP
- Use OOP classes only for connectors and interfaces to external systems
- Write pure functions - only modify return values, never input parameters or global state
- Follow DRY, KISS, and YAGNI principles
- Use strict typing everywhere - function returns, variables, collections
- Check if logic already exists before writing new code
- Avoid untyped variables and generic types
- Never use default parameter values - make all parameters explicit
- Create proper type definitions for complex data structures
- All imports at the top of the file
- Write simple single-purpose functions - no multi-mode behavior, no flag parameters that switch logic

## Error Handling

- Always raise errors explicitly, never silently ignore them
- Use specific error types that clearly indicate what went wrong
- Avoid catch-all exception handlers that hide the root cause
- Error messages should be clear and actionable
- No fallbacks unless I explicitly ask for them
- Fix root causes, not symptoms
- External API or service calls: use retries with warnings, then raise the last error
- Error messages must include enough context to debug: request params, response body, status codes
- Logging should use structured fields instead of interpolating dynamic values into message strings

## Tooling and Dependencies

- Prefer modern package management files like `pyproject.toml` and `package.json`
- Install dependencies in project environments, not globally
- Add dependencies to project config files, not as one-off manual installs
- Read installed dependency source code when needed instead of guessing behavior

## Testing

- Respect the current repository testing strategy and existing test suite
- Do not add new unit tests by default
- When tests are needed, prefer integration, end-to-end, or smoke tests that validate real behavior
- Use unit tests only rarely, mainly for stable datasets or pure data transformations
- Never add unit tests just to increase coverage numbers
- Avoid mocks when real calls are practical
- It is usually better to spend a little money on real API or service calls than to maintain fragile mock-based coverage
- Add only the minimum test coverage needed for the requested change

## Codex Workflow

- Inspect the repository before editing
- Read active `AGENTS.md` files before making assumptions
- Keep changes minimal and directly related to the current request
- Match the existing repository style even when it differs from my personal preference
- Do not revert unrelated changes
- Prefer `rg` for code search
- Use non-interactive commands with flags
- Always use non-interactive git diff: `git --no-pager diff` or `git diff | cat`
- Run relevant tests or validation commands after code changes when the project already defines them

## Documentation

- Code is the primary documentation - use clear naming, types, and docstrings
- Keep documentation in docstrings of the functions or classes they describe, not in separate files
- Separate docs files only when a concept cannot be expressed clearly in code
- Never duplicate documentation across files
- Store knowledge as current state, not as a changelog of modifications

## Commits

- Never create a git commit unless the user explicitly asks for one
- Uncommitted changes are the user's review state — they read the diff before deciding what to commit
- Keep changes uncommitted until asked, so the diff stays clean and reviewable

## Golang

- Run tests with GOCACHE=/tmp/go-build-cache
            ]],
          },
        },
        inline = {
          adapter = {
            name = main_adapter,
            model = inline_model,
          },
        },
        cmd = {
          adapter = main_adapter,
        },
      },
      prompt_library = {
        -- https://github.com/olimorris/codecompanion.nvim/blob/main/doc/RECIPES.md
        ['Code review'] = {
          interaction = 'chat',
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
              content = 'Please review provided code.\n' .. '#{buffer} #{lsp}',
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
