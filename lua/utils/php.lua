M = {}

function M.get_namespace()
   -- prepare name and path
   local path = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':~:.')
   print(path)
   -- find psr4 in composer.json
   local psr4 = {}
   local is_psr4 = false
   local composerPath = vim.fn.getcwd() .. '/composer.json'
   for line in io.lines(composerPath) do
      if string.find(line, '}$') then
         is_psr4 = false
      end

      if is_psr4 then
         local parts = vim.split(vim.trim(line):gsub('[" ,]+', ''), ':')
         psr4[parts[1]:gsub('\\\\', '\\')] = parts[2]
      end

      if string.find(line, '"psr%-4": {') then
         is_psr4 = true
      end
   end

   -- fix by psr4
   if vim.tbl_count(psr4) > 0 then
      for value, key in pairs(psr4) do
         path = string.gsub(path, key, value)
      end
   else
      return false
   end

   -- fix slashes
   path = path:gsub('/', '\\\\')

   return path
end

return M
