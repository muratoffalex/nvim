local prompts = {
  BetterNamings = 'Please provide better names for the following variables and functions.',
  -- Text related prompts
  -- Summarize = 'Please summarize the following text.',
  -- Spelling = 'Please correct any grammar and spelling errors in the following text.',
  -- Wording = 'Please improve the grammar and wording of the following text.',
  -- Concise = 'Please rewrite the following text to make it more concise.',
}

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  enabled = false,
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = function()
    local COPILOT_INSTRUCTIONS = require('CopilotChat.config.prompts').COPILOT_INSTRUCTIONS.system_prompt
      .. 'Answer in russian.'
    return {
      log_level = 'warn',
      system_prompt = COPILOT_INSTRUCTIONS,
      model = 'deepseek/deepseek-chat-v3-0324',
      auto_follow_cursor = false,
      prompts = {
        BetterNamings = prompts.BetterNamings,
      },
      highlight_headers = false,
      separator = '',
      answer_header = '## Copilot',
      question_header = '## User',
      error_header = '> [!ERROR] Error',
      providers = {
        github_models = {
          disabled = true,
        },
        openrouter = {
          prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
          prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,

          get_headers = function()
            local api_key = assert(os.getenv 'OPENROUTER_API_KEY', 'OPENROUTER_API_KEY env not set')
            return {
              Authorization = 'Bearer ' .. api_key,
              ['Content-Type'] = 'application/json',
            }
          end,

          get_models = function(headers)
            local response, err = require('CopilotChat.utils').curl_get('https://openrouter.ai/api/v1/models', {
              headers = headers,
              json_response = true,
            })

            if err then
              error(err)
            end

            local allowed_models = {
              ['deepseek/deepseek-r1'] = true,
              ['deepseek/deepseek-chat-v3-0324'] = true,
            }

            return vim
              .iter(response.body.data)
              :filter(function(model)
                return allowed_models[model.id]
              end)
              :map(function(model)
                return {
                  id = model.id,
                  name = model.name,
                }
              end)
              :totable()
          end,

          get_url = function()
            return 'https://openrouter.ai/api/v1/chat/completions'
          end,
        },
      },
    }
  end,
  config = function(_, opts)
    local chat = require 'CopilotChat'
    local select = require 'CopilotChat.select'

    chat.setup(opts)

    vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = '*', range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command('CopilotChatInline', function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = 'float',
          relative = 'cursor',
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = '*', range = true })

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    require('which-key').add {
      { 'cc', 'CopilotChat' },
    }
  end,
  keys = {
    { '<leader>cc', desc = 'CopilotChat' },
    -- Quick chat with Copilot
    {
      '<leader>ccq',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    {
      '<leader>ccq',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input)
        end
      end,
      mode = 'x',
      desc = 'CopilotChat - Quick chat',
    },
    {
      '<leader>ccm',
      '<cmd>CopilotChatModels<cr>',
      desc = 'CopilotChat - Select model',
    },
    {
      '<leader>ccp',
      function()
        require('CopilotChat').select_prompt {
          selection = require('CopilotChat.select').buffer,
        }
      end,
      desc = 'CopilotChat - Prompt actions',
    },
    {
      '<leader>ccp',
      ":lua require('CopilotChat.integrations.fzflua').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
      mode = 'x',
      desc = 'CopilotChat - Prompt actions',
    },
    {
      '<leader>ccv',
      ':CopilotChatVisual<cr>',
      mode = 'x',
      desc = 'CopilotChat - Open in vertical split',
    },
    {
      '<leader>cci',
      ':CopilotChatInline<cr>',
      mode = 'x',
      desc = 'CopilotChat - Inline chat',
    },
    { '<leader>cct', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
    { '<leader>ccr', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
    { '<leader>ccs', ':CopilotChatSave ', desc = 'CopilotChat - Save' },
    { '<leader>ccl', ':CopilotChatLoad ', desc = 'CopilotChat - Load' },

    {
      '<leader>ccS',
      function()
        local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        vim.fn.feedkeys(':CopilotChatSave ' .. cwd, 'n')
      end,
      desc = 'CopilotChat - Save project chat',
    },
    {
      '<leader>ccL',
      function()
        local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        vim.fn.feedkeys(':CopilotChatLoad ' .. cwd, 'n')
      end,
      desc = 'CopilotChat - Load project chat',
    },
  },
}
