local new_command = vim.api.nvim_create_user_command
local php_tb = require 'utils.template_builders.php'

-- php
new_command('PhpBuildFileByName', function (_)
   php_tb.buildFileByName()
end, { nargs = "*" , desc = "Init current php file" })

new_command('PhpBuild', function (opts)
   local args = opts.args
   local type = 'class'
   if args ~= nil and string.len(args) > 0 then
      type = args
   end
   php_tb.generate_base_template(type)
end, { nargs = "*" , desc = "Init current php file" })
