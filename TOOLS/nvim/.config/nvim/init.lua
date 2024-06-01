-- init.lua

-- Package Manager
require "packer".startup(
	function()
		use "wbthomason/packer.nvim"
		use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
		use "neovim/nvim-lspconfig"
		use "hrsh7th/nvim-compe"
		use { "catppuccin/nvim", as = "catppuccin" }
		use "whiteinge/diffconflicts"
		use "itchyny/lightline.vim"
		use "tpope/vim-surround"
		use "tpope/vim-commentary"
		use "tpope/vim-repeat"
		use "lukas-reineke/indent-blankline.nvim"
		use "bkad/CamelCaseMotion"
	end
)

-- Tree-sitter
local ts = require "nvim-treesitter.configs"
ts.setup {
	ensure_installed = { "c", "vim", "python" },
	highlight = {enable = true},
	indent = {enable = true},
}

-- LSP Client
local lsp = require "lspconfig"
lsp.pylsp.setup {}

vim.api.nvim_set_keymap("n", "<space>,", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>;", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {noremap = true})

-- Autocompletion
local comp = require "compe"
comp.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = "enable";
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		nvim_lsp = true;
	};
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	else
		return t "<S-Tab>"
	end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Colors
-- catppuccin setup
local catpp = require "catppuccin"
catpp.setup {
	background = {
		light = "latte",
		dark = "frappe",
	}
}
-- Set background mode
vim.opt.background = "dark"

-- Set color mods
vim.cmd "colorscheme catppuccin"

-- Spaces & Tabs
-- Number of visual spaces per TAB
vim.opt.tabstop = 4

-- Number of spaces in tab when editing
vim.opt.softtabstop = 4

-- Number of spaces for indent. '0' means 'tabstop' value.
vim.opt.shiftwidth = 0

-- Indent line when pressing TAB
vim.opt.smarttab = true

-- Tabs are spaces
vim.opt.expandtab = false

-- Auto indent
vim.opt.smartindent = true

-- Use to see the difference between tabs and spaces
vim.opt.list = true

-- Customize characters to use in list mode
vim.opt.listchars = {
	trail = "·",
	tab = "»·",
	eol = "¬"
}

-- UI Config
-- Show line numbers
vim.opt.number = true

-- Max width of text. Longer line will be broken after white space.
vim.opt.textwidth = 0

-- Comma separated list of screen columns that are highloghted.
-- Can be an absolute number, or a number preceded with '+' or '-', which is
-- added to or substracted from 'textwidth'.
vim.opt.colorcolumn = {100, 120}

-- Show command in bottom bar
vim.opt.showcmd = true

-- Highlight current line
vim.opt.cursorline = true

-- Disable cursor-styling
vim.opt.guicursor = ""

-- Visual autocomplete for command menu
vim.opt.wildmenu = true

-- Command-line completion mode
vim.opt.wildmode = {"list", "longest"}

-- Redraw only when needed to
vim.opt.lazyredraw = true

-- Highlight matching [{()}]
vim.opt.showmatch = true

-- Searching
-- Search as characters are entered
vim.opt.incsearch = true

-- Case insensitive
vim.opt.ignorecase = true

-- Highlight matches
vim.opt.hlsearch = true

-- Turn off search highlight
vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>nohlsearch<CR>", {noremap = true})

-- Folding
-- Enable folding
vim.opt.foldenable = true

-- Open most folds by default
vim.opt.foldlevelstart = 10

-- 10 nested fold max
vim.opt.foldnestmax = 10

-- space open/close folds
--vim.api.nvim_set_keymap("n", "<space>", "za", {noremap = true})

-- Fold based on indent level
vim.opt.foldmethod = "indent"

-- Key mappings
-- Leader is comma
--vim.g.mapleader = ","

-- Move vertically by visual line, even with 'relativenumber' set
vim.api.nvim_set_keymap("n", "<silent> <expr> j", "(v:count == 0 ? 'gj' : 'j'", {noremap = true})
vim.api.nvim_set_keymap("n", "<silent> <expr> k", "(v:count == 0 ? 'gk' : 'k'", {noremap = true})

-- Highlight last inserted text
vim.api.nvim_set_keymap("n", "gV", "`[v`]", {noremap = true})

-- Make 'Y' yank everything from cursor to end of line
vim.api.nvim_set_keymap("", "Y", "y$", {noremap = true})

-- Lightline
-- Show mode only on statusline
vim.opt.showmode = false

-- Lightline config
vim.g.lightline = {
	colorscheme = "catppuccin",
	active = {
		left = {
			{"mode", "paste"},
			{"readonly", "filename", "modified"}
		},
		right = {
			{"lineinfo"},
			{"percent"},
			{"fileformat", "fileencoding", "filetype"}
		}
	}
}

-- Tweaks
-- Toggle relativenumber
function toggleNumber()
	if vim.wo.relativenumber == true then
		vim.wo.relativenumber = false
	else
		vim.wo.relativenumber = true
	end
end
vim.api.nvim_set_keymap("n", "<leader>l", ":lua toggleNumber()<CR>", {noremap = true})
