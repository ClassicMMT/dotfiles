local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  s(
    "textbf",
    f(function(_, snip)
      local res, env = {}, snip.env
      for _, ele in ipairs(env.LS_SELECT_RAW) do
        table.insert(res, "\\textbf{" .. ele .. "}")
      end
      return res
    end, {})
  ),

  s("expand", t { "-- this is what was expanded!" }),

  -- s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}
