-- NOTE: for testing, not sure if this is a good idea
-- maybe constant visibility is better
return {
  'm4xshen/smartcolumn.nvim',
  opts = {
    colorcolumn = { '80', '120' },
    disabled_filetypes = {
      'help',
      'text',
      'Trouble',
      'neo-tree',
      'dbui',
      'mason',
      'lazy',
      'copilot-chat',
      'Avante',
      'codecompanion',
    },
    custom_colorcolumn = {
      markdown = '80',
      go = { '80', '100' },
    },
  },
}
