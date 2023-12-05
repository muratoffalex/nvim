return {
  'vuki656/package-info.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('package-info').setup()
  end,
  keys = {
    -- TODO: add more keybindings
    { '<leader>ps', '<cmd>lua require("package-info").show()<cr>',   desc = '[package.json] Show dependency versions',   silent = true, noremap = true },
    { '<leader>pt', '<cmd>lua require("package-info").toggle()<cr>', desc = '[package.json] Toggle dependency versions', silent = true, noremap = true },
  },
}
