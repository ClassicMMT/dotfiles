-- local cmp = require "cmp"
return {
  -- modified from: ~/.local/share/nvim/lazy/NvChad/lua/nvchad
  "windwp/nvim-autopairs",
  opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    local rule = require "nvim-autopairs.rule"

    local autopairs = require "nvim-autopairs"
    autopairs.add_rules {
      rule("\\(", "\\)", "tex"),
      rule("$", "$", { "tex", "markdown", "typst" }),
      rule("\\[", "\\]", "tex"),
      rule("\\{", "\\}", "tex"),
    }

    --   -- setup cmp for autopairs
    --   local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    --   require("cmp").event:on(
    --     "confirm_done",
    --     cmp_autopairs.on_confirm_done {
    --       -- custom config - stops autopairs from inserting brackets after function calls in python
    --       filetypes = {
    --         ["python"] = {
    --           ["("] = {
    --             kind = {
    --               cmp.lsp.CompletionItemKind.Function,
    --               cmp.lsp.CompletionItemKind.Method,
    --             },
    --             handler = function() end,
    --           },
    --         },
    --       },
    --     }
    --   )
  end,
}
