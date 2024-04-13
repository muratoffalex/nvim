# Neovim Configuration for Web Development

This repository contains a Neovim configuration tailored for web development,
including languages such as PHP, JavaScript, TypeScript, React, and Vue.

## Description

This configuration is designed to provide a robust and efficient development
environment for web technologies. It includes a variety of plugins and settings
to enhance productivity and ease of use.

## Plugins

The configuration includes a variety of plugins to enhance the functionality of
Neovim. These plugins will be installed and configured automatically when the
configuration is loaded.

## Dependencies

### Required

- `make`: Used for building and installing various components.
- `fzf`: A command-line fuzzy finder, used for file and command searching.
- `ripgrep`: A line-oriented search tool that recursively searches your current
  directory for a regex pattern.
- `node`: A JavaScript runtime built on Chrome's V8 JavaScript engine.
- `fd`: A simple, fast and user-friendly alternative to 'find'.

### Optional

- `mdcat`: A utility for viewing markdown files in the terminal.
- `bat`: A cat clone with syntax highlighting and Git integration.

## Key Mappings

This configuration includes a variety of custom key mappings to enhance
productivity. These mappings will be loaded automatically when the
configuration is loaded.

## Notes

For extra lazy loading, use `{ 'BufReadPost', 'BufWritePost', 'BufNewFile' }`
from LazyVim instead of `BufEnter`, because `BufEnter` is triggered after
`VimEnter`.

### Post-Initialization Commands

After initializing the configuration, run the following command to set the
default standard for PHP_CodeSniffer (lint):

```sh
~/.local/share/nvim/mason/bin/phpcs --config-set default_standard PSR12
```

## TODO

- Add a shell script with post-installation instructions.
