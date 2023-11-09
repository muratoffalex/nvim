return {
  "echasnovski/mini.map",
  version = "*",
  keys = {
    { "<leader>mo", "<cmd>lua require('mini.map').open()<cr>", desc = 'Minimap: Open' },
    { "<leader>mt", "<cmd>lua require('mini.map').toggle()<cr>", desc = 'Minimap: Toggle' },
  },
  config = function()
    local MiniMap = require "mini.map"
    MiniMap.setup {
      symbols = {
        encode = MiniMap.gen_encode_symbols.dot "4x2",
      },
      integrations = {
        MiniMap.gen_integration.builtin_search(),
        MiniMap.gen_integration.gitsigns(),
        MiniMap.gen_integration.diagnostic(),
      },
    }

    MiniMap.gen_integration.gitsigns()

    vim.keymap.set("n", "<Leader>mc", MiniMap.close, { desc = 'Minimap: Close' })
    vim.keymap.set("n", "<Leader>mf", MiniMap.toggle_focus, { desc = 'Minimap: Toggle focus' })
    vim.keymap.set("n", "<Leader>mr", MiniMap.refresh, { desc = 'Minimap: Refresh' })
    vim.keymap.set("n", "<Leader>ms", MiniMap.toggle_side, { desc = 'Minimap: Toggle side' })
  end,
}
