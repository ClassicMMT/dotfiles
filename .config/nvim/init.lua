local vim = vim
vim.loader.enable()

local global = vim.g
global.mapleader = " "

------------------------------------- Lazy -----

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "custom" },
	-- The basic modules are here. The customised ones are under the custom directory.
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "szw/vim-maximizer", keys = { { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Max/min a split" } } },
	{ "kylechui/nvim-surround", event = { "BufReadPre", "BufNewFile" }, version = "*", config = true },
}, {
	change_detection = { notify = false },
	checker = { enabled = true, notify = false },
})

------------------------------------- Key Maps -----

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<C-w>close<CR>", { desc = "Close current split" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open current buffer in new tab" })

------------------------------------- Options -----

local options = vim.opt

-- encoding
options.encoding = "utf-8"

-- general appearance
options.termguicolors = true
options.background = "dark"
options.signcolumn = "yes" -- for signs
global.netrw_liststyle = 3 -- tree structure

-- line numbers
options.relativenumber = true
options.number = true

-- search settings
options.smartcase = true
options.ignorecase = true
options.hlsearch = false
options.incsearch = true

-- tabbing
options.tabstop = 2
options.shiftwidth = 2
options.expandtab = true
options.autoindent = true

options.backup = false
options.swapfile = false

options.completeopt = "menu,menuone,noselect"
options.wrap = false
options.linebreak = true

-- window splits
options.splitright = true
options.splitbelow = true

-- scrolling
options.scrolloff = 8
options.sidescrolloff = 8

-- other
options.backspace = { "indent", "eol", "start" }
options.cursorline = true

options.clipboard = "unnamedplus"

options.iskeyword:append("-")

------------------------------------- Language specific settings
-- python formatting
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		options.textwidth = 79
		options.colorcolumn = "79"
		options.tabstop = 4
		options.shiftwidth = 4
		options.softtabstop = 4
	end,
})

-------------------------------------
