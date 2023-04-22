-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
    -- Treesitter
	Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'mfussenegger/nvim-ts-hint-textobject'
	
	-- Comments
	Plug 'terrortylor/nvim-comment'

	-- Lightspeed
	-- Plug 'ggandor/lightspeed.nvim'	

	-- Leap
	Plug 'ggandor/leap.nvim'

    -- Vim surround
    Plug 'tpope/vim-surround'
vim.call('plug#end')

-- Plugin config
require('nvim_comment').setup()
require('leap').add_default_mappings()

-- Vim-surround
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.cmd('let g:surround_no_mappings = 1')
map('n', 'ds', '<Plug>Dsurround', opts)
map('n', 'cs', '<Plug>Csurround', opts)
map('n', 'cS', '<Plug>CSurround', opts)
map('n', 'ys', '<Plug>Ysurround', opts)
map('n', 'yS', '<Plug>YSurround', opts)
map('n', 'yss', '<Plug>Yssurround', opts)
map('n', 'ySs', '<Plug>YSsurround', opts)
map('n', 'ySS', '<Plug>YSSurround', opts)
map('x', 'gs', '<Plug>VSurround', opts)
map('x', 'gS', '<Plug>VgSurround', opts)

-- Keymaps
map('n', 'K', '10k', opts)

-- Settings
local set = vim.opt
set.number = true
set.relativenumber = true

set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4

set.mouse = 'a'
set.clipboard = 'unnamed'

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.wrap = false
set.scrolloff = 5
set.fileencoding = 'utf-8'
set.termguicolors = true
set.cursorline = true
set.hidden = true
