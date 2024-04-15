local new_command = vim.api.nvim_create_user_command
local php_tb = require 'utils.template_builders.php'

-- php
new_command('PhpBuildFileByName', function(_)
   php_tb.build_by_file_name()
end, { nargs = '*', desc = 'Init current php file' })

new_command('PhpBuild', function(opts)
   local args = opts.args
   local type = 'class'
   if args ~= nil and string.len(args) > 0 then
      type = args
   end
   php_tb.build_base(type)
end, { nargs = '*', desc = 'Init current php file' })
