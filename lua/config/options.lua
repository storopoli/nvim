-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.o.nu = true
vim.o.relativenumber = true

-- Tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Lazy redraw for crazy macros
--vim.o.lazyredraw = true

-- A lot of plugins depends on hidden true
vim.o.hidden = true

-- set command line height to zero/two lines
-- vim.o.cmdheight = 2
vim.o.cmdheight = 0

-- Statusbar
vim.o.laststatus = 3

-- Winbar on top of the windows
vim.o.winbar = "%=%m %f"

-- Enable mouse mode
vim.o.mouse = "a"

-- Scrolling
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Time in milliseconds to wait for a mapped sequence to complete
vim.o.timeoutlen = 50
vim.o.ttyfast = true
vim.o.updatetime = 50

-- No wrap
vim.o.wrap = false

-- Enable break indent
vim.o.breakindent = true

-- Better undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "undo"
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- color column
vim.o.colorcolumn = "80"

-- Window splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Transparency
vim.o.winblend = 5


-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
