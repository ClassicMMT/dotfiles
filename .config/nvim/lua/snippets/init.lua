-- ~/.config/nvim/lua/snippets/init.lua
local ls = require "luasnip"
-- R snippets for both 'r' and 'rmd' filetypes
local r_snippets = require "snippets.r"
local rmd_snippets = require "snippets.rmd"
local lua_snippets = require "snippets.lua"
local tex_snippets = require "snippets.tex"

local utils = require "snippets.utils"

-- Load snippets from lua files
local load_snippets = function()
  ls.add_snippets("tex", tex_snippets)

  ls.add_snippets("rmd", rmd_snippets)
  ls.add_snippets("rmd", tex_snippets)

  ls.add_snippets("r", r_snippets)

  ls.add_snippets("lua", lua_snippets)
end

-- OTHER CUSTOM BEHAVIOUR

-- insert r code chunk with opt + ctrl + i
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rmd" },
  callback = function()
    local map = vim.keymap.set

    -- Create R code chunk with opt + ctrl + i
    map({ "i", "n" }, "<A-C-i>", utils.insert_r_chunk)

    -- Wrap selection in R code chunk with opt + ctrl + i in visual mode
    map("v", "<A-C-i>", utils.insert_r_chunk_visual, { buffer = true })
  end,
})

return {
  load = load_snippets,
}
