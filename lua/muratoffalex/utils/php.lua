M = {}

-- Get namespace for file or false
-- TODO: add handling dev namespaces
function M.get_namespace()
   -- prepare name and path
   local path = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':~:.')

   -- read and parse composer.json
   local composer_path = vim.fn.getcwd() .. '/composer.json'
   local file = io.open(composer_path, 'r')

   if file == nil then
      return false
   end

   local content = file:read('*all')
   file:close()

   local composer_data = vim.fn.json_decode(content)

   if composer_data == nil then
      return false
   end

   local psr4 = composer_data['autoload'] and composer_data['autoload']['psr-4'] or {}

   -- find and replace namespace in path
   local namespace_exist = false
   for value, key in pairs(psr4) do
      -- ex., src/ => src
      key = key:gsub('/', '')

      if string.find(path, key) then
         namespace_exist = true
         path = string.gsub(path, key, value:gsub('\\', ''))
      end
   end

   if not namespace_exist then
      return false
   end

   -- fix slashes
   -- ex., App/Test => App\Test
   path = path:gsub('/', '\\\\')

   return path
end

return M
