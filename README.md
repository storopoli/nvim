# Neovim Config

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

My Minimalist Neovim config.
Banish those unworthy [soydev](https://storopoli.io/2023-11-10-2023-11-13-soydev/)
IDEs to the depths of Hell!

![Screenshot](./screenshot.jpg)

## Dependencies

- Neovim:
  - `neovim`
  - `fzf`
  - `ripgrep`
  - `fd`
- LSPs:
  - `bash-language-server`
  - `typescript-language-server`
  - `rust-analyzer`
  - `gopls`
  - `vscode-langservers-extracted`
  - `pyright`
  - `lua-language-server`
  - `nil`
  - `taplo`
  - `yaml-language-server`
  - `marksman`
  - `typst-lsp`
- Linters:
  - `shellcheck`
  - `luacheck`
  - `ruff`
  - `eslint_d`
  - `luacheck`
- Formatters:
  - `dprint`
  - `prettierd`
  - `isort`
  - `black`
  - `shfmt`
  - `shellharden`
  - `stylua`
  - `nixpkgs-fmt`
  - `typstfmt`

## Nix Alternative

One can use the same configs here with one-liner:

```bash
nix run github:storopoli/neovix
```

or add to your flake.

Check [`storopoli/neovix`](https://github.com/storopoli/neovix) for more details.
