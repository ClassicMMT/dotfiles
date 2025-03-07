require "nvchad.options"

local options = vim.opt
options.cursorlineopt = "both"

-- CUSTOM

-- scrolling
options.scrolloff = 8
-- options.sidescrolloff = 999
options.sidescrolloff = 8
options.wrap = true

-- wait until timeout
options.timeoutlen = 250

-- relative number
options.relativenumber = true
options.number = true

-- make "-" to be considered part of a word
options.iskeyword:append "-"

-- enable breakindent
options.breakindent = true
options.linebreak = true
options.breakindentopt = "shift:4"

vim.filetype.add { extension = { typ = "typst" } }

-- enable folding
options.foldmethod = "expr"
options.foldexpr = "nvim_treesitter#foldexpr()"
options.foldenable = false

-- -- enable python provider - Necessary for molten.nvim
-- local enable_providers = {
--   "python3_provider",
--   "node_provider",
-- }
--
-- for _, plugin in pairs(enable_providers) do
--   vim.g["loaded_" .. plugin] = nil
--   vim.cmd("runtime " .. plugin)
-- end
-- -- End Necessary for molten.nvim

-- -- custom for html
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*.html",
--   callback = function()
--     options.tabstop = 4
--     options.shiftwidth = 4
--     options.softtabstop = 4
--   end,
-- })
