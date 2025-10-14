-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- Border style
vim.o.winborder = 'rounded'

-- Font
vim.g.have_nerd_font = true

-- Mouse
vim.opt.mouse = 'a'

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.breakindent = true

-- Undo
vim.opt.undofile = true

-- Casing
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Incremental command
vim.opt.inccommand = 'split'

-- Cursor line
vim.opt.cursorline = true

-- Status line
vim.opt.laststatus = 3

-- Scroll offset
vim.opt.scrolloff = 8

-- Search highlighting
vim.opt.hlsearch = true
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>')

-- Update time
vim.opt.updatetime = 250

-- Root spec
vim.g.root_spec = { "cwd" }

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
