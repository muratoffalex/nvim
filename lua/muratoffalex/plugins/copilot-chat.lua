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
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
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
    -- Show help actions with fzflua
    {
      '<leader>cch',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.fzflua').pick(actions.help_actions())
      end,
      desc = 'CopilotChat - Help actions',
    },
    {
      '<leader>ccm',
      '<cmd>CopilotChatModels<cr>',
      desc = 'CopilotChat - Select model',
    },
    -- Show prompts actions with fzflua
    {
      '<leader>ccp',
      function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.fzflua').pick(
          actions.prompt_actions { selection = require('CopilotChat.select').buffer }
        )
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
  },
  opts = {
    log_level = 'warn',
    model = 'claude-3.5-sonnet',
    auto_follow_cursor = false,
    prompts = {
      BetterNamings = prompts.BetterNamings,
    },
  },
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
  end,
}
