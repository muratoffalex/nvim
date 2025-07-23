-- https://ravitemer.github.io/mcphub.nvim/extensions/lualine.html#lualine-integration
return {
  function()
    -- Check if MCPHub is loaded
    if not vim.g.loaded_mcphub then
      return '󰐻 -'
    end

    local count = vim.g.mcphub_servers_count or 0
    local status = vim.g.mcphub_status or 'stopped'
    local executing = vim.g.mcphub_executing

    -- Show "-" when stopped
    if status == 'stopped' then
      return '󰐻 -'
    end

    -- Show spinner when executing, starting, or restarting
    if executing or status == 'starting' or status == 'restarting' then
      local frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
      local frame = math.floor(vim.loop.now() / 100) % #frames + 1
      return '󰐻 ' .. frames[frame]
    end

    return '󰐻 ' .. count
  end,
  color = function()
    if not vim.g.loaded_mcphub then
      return { fg = '#6c7086' } -- Gray for not loaded
    end

    local status = vim.g.mcphub_status or 'stopped'
    if status == 'ready' or status == 'restarted' then
      return "DiagnosticInfo" -- Green for connected
    elseif status == 'starting' or status == 'restarting' then
      return "DiagnosticWarn" -- Orange for connecting
    else
      return "DiagnosticError" -- Red for error/stopped
    end
  end,
}
