return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'MCPHub',
  opts = {
    auto_approve = false,
    extensions = {
      avante = {},
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
