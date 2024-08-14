vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- encoding
opt.encoding = "utf-8"

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- spaces for tabs
opt.shiftwidth = 4 -- spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- :h signcolumn

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- considers the dash as part of a word
opt.iskeyword:append("-")

-- scrolling
opt.scrolloff = 8 -- minimum number of lines above and below cursor when scrolling
opt.sidescrolloff = 8 -- minimum number of columns

-- python formatting
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.py",
    callback = function()
        opt.textwidth = 79
        opt.colorcolumn = "79"
    end
})

-- R formatting
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.R", "*.Rmd"},
    callback = function()
        opt.tabstop = 2
        opt.shiftwidth = 2
        opt.softtabstop = 2
    end
})
