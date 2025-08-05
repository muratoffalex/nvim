local userConfig = require 'muratoffalex.config'

return {
  'ravitemer/mcphub.nvim',
  enabled = userConfig.current_os == 'nixos',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = userConfig.current_os ~= 'nixos' and 'npm install -g mcp-hub@latest' or nil,
  cmd = 'MCPHub',
  opts = {
    auto_approve = false,
    extensions = {
      codecompanion = {
        -- Show the mcp tool result in the chat buffer
        show_result_in_chat = true,
        -- Make chat #variables from MCP server resources
        make_vars = true,
        -- Create slash commands for prompts
        make_slash_commands = true,
      },
    },
  },
}
