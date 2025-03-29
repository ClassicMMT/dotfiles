local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local fmt = require("luasnip.extras.fmt").fmt

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

  s("frac", {
    t "\\frac{",
    i(1, "numerator"),
    t "}{",
    i(2, "denominator"),
    t "}",
  }),

  s("sqrt", {
    t "\\sqrt{",
    i(1),
    t "}",
  }),

  s("text", {
    t "\\text{",
    i(1),
    t "}",
  }),

  s({
    trig = ";j",
    snippetType = "autosnippet",
    desc = "equation",
    wordTrig = false,
  }, {
    t { "$$", "" },
    i(1),
    t { "", "$$" },
  }),

  -- autosnippets
  s({ trig = ";a", snippetType = "autosnippet", desc = "alpha", wordTrig = false }, { t "\\alpha" }),
  s({ trig = ";A", snippetType = "autosnippet", desc = "Alpha", wordTrig = false }, { t "A" }),

  s({ trig = ";b", snippetType = "autosnippet", desc = "beta", wordTrig = false }, { t "\\beta" }),
  s({ trig = ";B", snippetType = "autosnippet", desc = "Beta", wordTrig = false }, { t "B" }),

  s({ trig = ";g", snippetType = "autosnippet", desc = "gamma", wordTrig = false }, { t "\\gamma" }),
  s({ trig = ";G", snippetType = "autosnippet", desc = "Gamma", wordTrig = false }, { t "\\Gamma" }),

  s({ trig = ";d", snippetType = "autosnippet", desc = "delta", wordTrig = false }, { t "\\delta" }),
  s({ trig = ";D", snippetType = "autosnippet", desc = "Delta", wordTrig = false }, { t "\\Delta" }),

  s({ trig = ";e", snippetType = "autosnippet", desc = "epsilon", wordTrig = false }, { t "\\epsilon" }),
  s({ trig = ";E", snippetType = "autosnippet", desc = "Epsilon", wordTrig = false }, { t "E" }),

  s({ trig = ";z", snippetType = "autosnippet", desc = "zeta", wordTrig = false }, { t "\\zeta" }),
  s({ trig = ";Z", snippetType = "autosnippet", desc = "Zeta", wordTrig = false }, { t "Z" }),

  s({ trig = ";h", snippetType = "autosnippet", desc = "eta", wordTrig = false }, { t "\\eta" }),
  s({ trig = ";H", snippetType = "autosnippet", desc = "Eta", wordTrig = false }, { t "H" }),

  s({ trig = ";q", snippetType = "autosnippet", desc = "theta", wordTrig = false }, { t "\\theta" }),
  s({ trig = ";Q", snippetType = "autosnippet", desc = "Theta", wordTrig = false }, { t "\\Theta" }),

  s({ trig = ";i", snippetType = "autosnippet", desc = "iota", wordTrig = false }, { t "\\iota" }),
  s({ trig = ";I", snippetType = "autosnippet", desc = "Iota", wordTrig = false }, { t "I" }),

  s({ trig = ";k", snippetType = "autosnippet", desc = "kappa", wordTrig = false }, { t "\\kappa" }),
  s({ trig = ";K", snippetType = "autosnippet", desc = "Kappa", wordTrig = false }, { t "K" }),

  s({ trig = ";l", snippetType = "autosnippet", desc = "lambda", wordTrig = false }, { t "\\lambda" }),
  s({ trig = ";L", snippetType = "autosnippet", desc = "Lambda", wordTrig = false }, { t "\\Lambda" }),

  s({ trig = ";m", snippetType = "autosnippet", desc = "mu", wordTrig = false }, { t "\\mu" }),
  s({ trig = ";M", snippetType = "autosnippet", desc = "Mu", wordTrig = false }, { t "M" }),

  s({ trig = ";n", snippetType = "autosnippet", desc = "nu", wordTrig = false }, { t "\\nu" }),
  s({ trig = ";N", snippetType = "autosnippet", desc = "Nu", wordTrig = false }, { t "N" }),

  s({ trig = ";x", snippetType = "autosnippet", desc = "xi", wordTrig = false }, { t "\\xi" }),
  s({ trig = ";X", snippetType = "autosnippet", desc = "Xi", wordTrig = false }, { t "\\Xi" }),

  s({ trig = ";o", snippetType = "autosnippet", desc = "omicron", wordTrig = false }, { t "o" }),
  s({ trig = ";O", snippetType = "autosnippet", desc = "Omicron", wordTrig = false }, { t "O" }),

  s({ trig = ";p", snippetType = "autosnippet", desc = "pi", wordTrig = false }, { t "\\pi" }),
  s({ trig = ";P", snippetType = "autosnippet", desc = "Pi", wordTrig = false }, { t "\\Pi" }),

  s({ trig = ";r", snippetType = "autosnippet", desc = "rho", wordTrig = false }, { t "\\rho" }),
  s({ trig = ";R", snippetType = "autosnippet", desc = "Rho", wordTrig = false }, { t "P" }),

  s({ trig = ";s", snippetType = "autosnippet", desc = "sigma", wordTrig = false }, { t "\\sigma" }),
  s({ trig = ";S", snippetType = "autosnippet", desc = "Sigma", wordTrig = false }, { t "\\Sigma" }),

  s({ trig = ";t", snippetType = "autosnippet", desc = "tau", wordTrig = false }, { t "\\tau" }),
  s({ trig = ";T", snippetType = "autosnippet", desc = "Tau", wordTrig = false }, { t "T" }),

  s({ trig = ";u", snippetType = "autosnippet", desc = "upsilon", wordTrig = false }, { t "\\upsilon" }),
  s({ trig = ";U", snippetType = "autosnippet", desc = "Upsilon", wordTrig = false }, { t "\\Upsilon" }),

  s({ trig = ";f", snippetType = "autosnippet", desc = "phi", wordTrig = false }, { t "\\phi" }),
  s({ trig = ";F", snippetType = "autosnippet", desc = "Phi", wordTrig = false }, { t "\\Phi" }),

  s({ trig = ";c", snippetType = "autosnippet", desc = "chi", wordTrig = false }, { t "\\chi" }),
  s({ trig = ";C", snippetType = "autosnippet", desc = "Chi", wordTrig = false }, { t "X" }),

  s({ trig = ";y", snippetType = "autosnippet", desc = "psi", wordTrig = false }, { t "\\psi" }),
  s({ trig = ";Y", snippetType = "autosnippet", desc = "Psi", wordTrig = false }, { t "\\Psi" }),

  s({ trig = ";w", snippetType = "autosnippet", desc = "omega", wordTrig = false }, { t "\\omega" }),
  s({ trig = ";W", snippetType = "autosnippet", desc = "Omega", wordTrig = false }, { t "\\Omega" }),
}
