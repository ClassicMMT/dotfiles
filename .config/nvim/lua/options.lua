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

-- inlay hints
vim.lsp.inlay_hint.enable(true)

-- diagnostics for current line (nvim >= 0.11)
vim.diagnostic.config { virtual_text = { current_line = true } }

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

-- set correct filetype for latex
vim.g.tex_flavor = "latex"
