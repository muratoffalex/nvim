return {
  'yetone/avante.nvim',
  version = false,
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
    provider = 'openrouter',
    behaviour = {
      auto_suggestions = false,
    },
    providers = {
      openrouter = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = 'deepseek/deepseek-chat-v3-0324',
      },
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
    -- Using function prevents requiring mcphub before it's loaded
    windows = {
      width = 35,
    },
  },
  config = function(_, opts)
    local exists, mcphub = pcall(require, 'mcphub')
    if exists then
      opts.disabled_tools = {
        'list_files', -- Built-in file operations
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash', -- Built-in terminal access
      }
      opts.custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end
      opts.system_prompt = function()
        if mcphub == nil then
          return ''
        end
        return mcphub:get_active_servers_prompt()
      end
    end
    require('avante').setup(opts)
  end,
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.icons',
    'MeanderingProgrammer/render-markdown.nvim',
  },
}
