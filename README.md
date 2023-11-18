# Nvim config for web development (php, js, ts, react, vue)

## Dependencies

- make
- fzf
- ripgrep
- ...

## Notes

Use { 'BufReadPost', 'BufWritePost', 'BufNewFile' } (LazyExtra from LazyVim) for
extra lazy loading instead BufEnter, because BufEnter triggered after VimEnter
