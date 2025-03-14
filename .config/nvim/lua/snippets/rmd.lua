local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local fmt = require("luasnip.extras.fmt").fmt

return {
  -- R Markdown chunk
  r_chunk = s({
    trig = "chunk",
    name = "R Markdown Chunk",
    dscr = "Insert an R code chunk",
  }, {
    t { "```{r}", "" },
    i(0),
    t { "", "```" },
  }),
  -- s({ trig = ";a", snippetType = "autosnippet", desc = "alpha", wordTrig = false }, { t "\\alpha" }),
  --
  -- r_chunk_visual = s({
  --   trig = "chunk",
  --   name = "R Markdown Chunk",
  --   dscr = "Wrap selected text in an R code chunk",
  -- }, {
  --   t { "```{r}", "" },
  --   i(1, { "" }), -- Placeholder for the selected text
  --   t { "", "```" },
  -- }),
}
