local utils = require 'utils.php'

local types = {
   class = 'class',
   interface = 'interface',
   trait = 'trait',
   enum = 'enum',
   abstract_class = 'abstract class',
}

local templates_dir = '~/.config/nvim/templates/php/'

local templates = {
   empty = templates_dir .. 'empty.php',
   base = templates_dir .. 'base.php',
}

local function get_template_file(template_path)
   if not vim.fn.filereadable(template_path) then
      print('Template file not found or not readable: ' .. template_path)
      return false
   end

   return template_path
end

local M = {}

function M.build_empty()
   local template_file = get_template_file(templates.empty)
   if not template_file then
      return
   end

   vim.cmd('silent! 0r ' .. template_file)

   vim.fn.feedkeys '5gg'
end

function M.build_base(custom_type)
   local type = custom_type or 'class'

   local template_file = get_template_file(templates.base)
   if not template_file then
      return
   end

   local namespace = utils.get_namespace()

   vim.cmd('silent! 0r ' .. template_file)
   vim.cmd("%s/%namespace%/\\=expand('" .. namespace .. "')")
   vim.cmd("%s/%object_type%/\\=expand('" .. type .. "')")
   vim.cmd "%s/%file_name%/\\=expand('%:t:r')"

   vim.fn.feedkeys '9gg'
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

function M.build_by_content()
   local namespace = utils.get_namespace()

   if not namespace then
      M.build_empty()
      return
   else
      M.build_by_file_name()
   end
end

return M
