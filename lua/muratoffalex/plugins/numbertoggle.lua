-- Enable relativenumber when not insert mode
-- alternatvie with more customizing https://github.com/cpea2506/relative-toggle.nvim
return {
  'sitiom/nvim-numbertoggle',
  event = 'BufReadPre',
}
