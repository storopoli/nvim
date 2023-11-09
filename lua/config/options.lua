-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Lazy redraw for crazy macros
--vim.opt.lazyredraw = true

-- A lot of plugins depends on hidden true
vim.opt.hidden = true

-- set command line height to zero/two lines
-- vim.opt.cmdheight = 2
vim.opt.cmdheight = 0

-- Statusbar
vim.opt.laststatus = 3

-- Winbar on top of the windows
vim.opt.winbar = "%=%m %f"

-- Enable mouse mode
vim.opt.mouse = "a"

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.timeoutlen = 50

-- No wrap
vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true

-- Better undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = "yes"

-- color column
vim.opt.colorcolumn = "80"

-- Window splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
