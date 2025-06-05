local ok, mcp = pcall(require, 'mcphub.extensions.lualine')
if not ok then
  return ''
end
local update_status = mcp.update_status

----@diagnostic disable: duplicate-set-field
function mcp:update_status()
  local status = update_status(self)
  -- remove extra space
  return status:sub(1, -4) .. status:sub(-2)
end

return mcp
