local vaults_directory = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents'

return {
   'epwalsh/obsidian.nvim',
   version = '*', -- recommended, use latest release instead of latest commit
   lazy = true,
   cmd = {
      'ObsidianNew',
      'ObsidianOpen',
      'ObsidianQuickSwitch',
      'ObsidianFollowLink',
      'ObsidianBacklinks',
      'ObsidianTags',
      'ObsidianToday',
      'ObsidianYersterday',
      'ObsidianTomorrow',
      'ObsidianDailies',
      'ObsidianTemplate',
      'ObsidianSearch',
      'ObsidianLink',
      'ObsidianLinkNew',
      'ObsidianLinks',
      'ObsidianExtractNote',
      'ObisidianWorkspace',
      'ObsidianPasteImg',
      'ObsidianRename',
      'ObsidianToggleCheckbox'
   },
   event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      'BufReadPre ' .. vaults_directory .. '/**/**.md',
      'BufNewFile ' .. vaults_directory .. '/**/**.md',
   },
   dependencies = {
      'nvim-lua/plenary.nvim',
   },
   opts = {
      workspaces = {
         {
            name = 'omain',
            path = vaults_directory .. '/omain',
         },
         {
            name = 'owork',
            path = vaults_directory .. '/owork',
         },
      },
   },
}
