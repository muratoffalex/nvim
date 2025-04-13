return {
  'milanglacier/minuet-ai.nvim',
  enabled = false,
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
      provider_options = {
        openai_compatible = {
          end_point = 'https://api.deepseek.com/v1/chat/completions',
          api_key = 'DEEPSEEK_API_KEY',
          name = 'deepseek',
          model = 'deepseek-chat',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
        openai_fim_compatible = {
          api_key = 'DEEPSEEK_API_KEY',
          name = 'deepseek',
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
      context_window = 768,
      request_timeout = 20,
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
