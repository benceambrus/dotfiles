-- Global options
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.scrolloff = 4

vim.g.mapleader = ","

-- Lazy.nvim
require("config.lazy")

