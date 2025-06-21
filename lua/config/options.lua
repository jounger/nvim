-- OPTIONS
local set = vim.opt

-- line nums
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- appearance
set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"

-- cursor line
set.cursorline = true

-- 80th column
set.colorcolumn = "80"

-- keep cursor at least 8 rows from top/bot
set.scrolloff = 8
