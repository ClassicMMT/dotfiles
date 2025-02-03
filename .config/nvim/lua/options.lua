require "nvchad.options"

local options = vim.opt
options.cursorlineopt = "both"

-- CUSTOM

-- scrolling
options.scrolloff = 8
options.sidescrolloff = 8

-- wait until timeout
options.timeoutlen = 250

-- relative number
options.relativenumber = true
options.number = true

-- make "-" to be considered part of a word
options.iskeyword:append "-"

-- -- custom for html
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*.html",
--   callback = function()
--     options.tabstop = 4
--     options.shiftwidth = 4
--     options.softtabstop = 4
--   end,
-- })
