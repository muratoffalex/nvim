-- syntax highlight for chezmoi templates
return {
  'alker0/chezmoi.vim',
  lazy = false,
  init = function()
    vim.g['chezmoi#use_tmp_buffer'] = true
  end,
}
