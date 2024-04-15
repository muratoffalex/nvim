local utils = require 'utils.php'

local types = {
   class = 'class',
   interface = 'interface',
   trait = 'trait',
   enum = 'enum',
   abstract_class = 'abstract class',
}

local M = {}

function M.build_base(custom_type)
   local type = custom_type or 'class'

   -- Check if the template file exists and is readable
   local template_file = '~/.config/nvim/templates/php/base.php'
   if not vim.fn.filereadable(template_file) then
      print('Template file not found or not readable: ' .. template_file)
      return
   end

   local namespace = utils.get_namespace()

   vim.cmd('silent! 0r ' .. template_file)
   vim.cmd("%s/%namespace%/\\=expand('" .. namespace .. "')")
   vim.cmd("%s/%object_type%/\\=expand('" .. type .. "')")
   vim.cmd "%s/%file_name%/\\=expand('%:t:r')"

   vim.fn.feedkeys '8gg S'
end

M.build_class = function()
   M.build_base(types.class)
end

M.build_interface = function()
   M.build_base 'interface'
end

M.build_trait = function()
   M.build_base 'trait'
end

M.build_enum = function()
   M.build_base 'enum'
end

M.build_abstract_class = function()
   M.build_base 'abstract class'
end

function M.build_by_file_name()
   local file = vim.fn.expand '%:t:r'

   if string.match(file, 'Interface') then
      M.build_interface()
   elseif string.match(file, 'Trait') then
      M.build_trait()
   elseif string.match(file, 'Enum') then
      M.build_enum()
   elseif string.match(file, '^Abstract') then
      M.build_abstract_class()
   else
      M.build_class()
   end
end

return M
