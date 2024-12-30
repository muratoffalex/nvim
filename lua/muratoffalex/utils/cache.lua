-- very simple cache on file system
M = {}

M.read_value = function(key, default)
  local home = os.getenv 'HOME'
 local cache_path = home .. '/.cache/settings/' .. key
  local file = io.open(cache_path, 'r')
  if not file then
    return default
  end

  local content = file:read '*line'
  file:close()

  return content or default
end

return M
