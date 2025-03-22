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
    t { "", "```{r}", "" },
    i(0),
    t { "", "```", "" },
  }),

  r_chunk_visual = s({
    trig = "chunk",
    name = "R Markdown Chunk",
    dscr = "Insert an R code chunk",
  }, {
    t { "```{r}", "```" },
  }),

  r_chunk_inverted = s({
    trig = "chunk",
    name = "R Markdown Chunk",
    dscr = "Insert an R code chunk",
  }, {
    t { "```", "", "" },
    i(0),
    t { "", "", "```{r}" },
  }),
}
