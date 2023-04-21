-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"

-- Scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Time in milliseconds to wait for a mapped sequence to complete
vim.o.timeoutlen = 500

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Window splitting
vim.o.splitbelow = true
vim.o.splitright = true
