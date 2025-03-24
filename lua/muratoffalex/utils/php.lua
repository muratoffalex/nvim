M = {}

-- Get namespace for file or false
-- TODO: add handling dev namespaces
function M.get_namespace()
  local path = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':~:.')

  local composer_path = vim.fn.getcwd() .. '/composer.json'
  local file = io.open(composer_path, 'r')

  if file == nil then
    return false
  end

  local content = file:read '*all'
  file:close()

  local composer_data = vim.fn.json_decode(content)

  if composer_data == nil then
    return false
  end

  local psr4 = composer_data['autoload'] and composer_data['autoload']['psr-4'] or {}

  -- find and replace namespace in path
  local namespace_exist = false
  for namespace, dir in pairs(psr4) do
    -- ex., src/ => src
    dir = dir:gsub('/$', '')

    -- vim.notify("Namespace: [" .. namespace .. "], Dir: [" .. dir .. "]")
    if string.find(path, dir .. '/') == 1 then
      namespace_exist = true
      local remaining_path = string.sub(path, string.len(dir) + 2)
      namespace = namespace:gsub('\\', "\\\\")
      namespace = namespace:gsub('\\+$', "")
      path = namespace .. "\\\\" .. remaining_path:gsub('/', '\\\\')
      -- vim.notify("Final path: [" .. path .. "]")
      break
    end
  end

  if not namespace_exist then
    return false
  end

  return path
end

return M
