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
  - `julials`
  - `vscode-langservers-extracted`
  - `pyright`
  - `lua-language-server`
  - `nil`
  - `taplo`
  - `yaml-language-server`
  - `marksman`
  - `ltex-ls`
  - `typst-lsp`
- Linters:
  - `shellcheck`
  - `luacheck`
  - `ruff`
  - `eslint_d`
- Formatters:
  - `markdownlint-cli2`
  - `prettierd` or `prettier`
  - `isort`
  - `black`
  - `shfmt`
  - `shellharden`
  - `stylua`
  - `nixpkgs-fmt`
  - `typstfmt`

## Local Configurations with `exrc`

Local settings can be configured by  creating a `.nvim.lua` file in the project's
root directory.
If neovim is launched in the same directory as `.nvim.lua`,
it will evaluate your user configuration first,
followed by the local configuration.

An example `.nvim.lua` might be as follows:

```lua
local nvim_lsp = require('lspconfig')

nvim_lsp.rust_analyzer.setup({
  root_dir = function()
    return vim.fn.getcwd()
  end
})
```

## Nix Alternative

One can use the same configs here with one-liner:

```bash
nix run github:storopoli/neovix
```

or add to your flake.

Check [`storopoli/neovix`](https://github.com/storopoli/neovix) for more details.
