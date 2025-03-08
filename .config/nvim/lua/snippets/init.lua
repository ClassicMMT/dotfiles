-- ~/.config/nvim/lua/snippets/init.lua
local ls = require "luasnip"

-- Load snippets from lua files
local load_snippets = function()
  -- R snippets for both 'r' and 'rmd' filetypes
  local r_snippets = require "snippets.r"
  local rmd_snippets = require "snippets.rmd"
  local lua_snippets = require "snippets.lua"
  local tex_snippets = require "snippets.tex"

  ls.add_snippets("r", r_snippets)
  ls.add_snippets("rmd", rmd_snippets)
  ls.add_snippets("lua", lua_snippets)
  ls.add_snippets("tex", tex_snippets)
end

return {
  load = load_snippets,
}
