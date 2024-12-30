return {
  {
    -- jujutsu squashing
    'julienvincent/hunk.nvim',
    cmd = { 'DiffEditor' },
    opts = {},
  },
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
  },
}
