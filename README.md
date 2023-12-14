# Nvim config for web development (php, js, ts, react, vue)

## Description

## Plugins

## Dependencies

### Required

- make
- fzf
- ripgrep
- node
- fd
- ...

### Optional

- _mdcat_ - fancy markdown preview
- _bat_ - better cat

## Mapping

## Notes

Use { 'BufReadPost', 'BufWritePost', 'BufNewFile' } (LazyExtra from LazyVim) for
extra lazy loading instead BufEnter, because BufEnter triggered after VimEnter

### After init run commands

- Set default standard for PHP_CodeSniffer (lint)

```sh
  ~/.local/share/nvim/mason/bin/phpcs --config-set default_standard PSR12
```

### TODO

- Add sh file with after install instructions
