return {
  'milanglacier/minuet-ai.nvim',
  enabled = false,
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
      debug = true,
      request_timeout = 5,
      throttle = 1500, -- Increase to reduce costs and avoid rate limits
      debounce = 600, -- Increase to reduce costs and avoid rate limits
      context_window = 768,
      provider_options = {
        openai_compatible = {
          api_key = 'OPENROUTER_API_KEY',
          end_point = 'https://openrouter.ai/api/v1/chat/completions',
          model = 'openai/gpt-4.1-nano',
          name = 'Openrouter',
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            provider = {
              -- Prioritize throughput for faster completion
              sort = 'throughput',
            },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { '*' },
        auto_trigger_ignore_ft = { 'markdown' },
        keymap = {
          -- accept whole completion
          accept = '<A-g>',
          -- accept one line
          accept_line = '<A-G>',
          -- accept n lines (prompts for number)
          -- e.g. "A-z 2 CR" will accept 2 lines
          accept_n_lines = '<A-z>',
          -- Cycle to prev completion item, or manually invoke completion
          prev = '<A-,>',
          -- Cycle to next completion item, or manually invoke completion
          next = '<A-.>',
          dismiss = '<A-d>',
        },
        show_on_completion_menu = true,
      },
    }
  end,
}
