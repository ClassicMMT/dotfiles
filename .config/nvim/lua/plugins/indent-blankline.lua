local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        event = "User FilePost",

        opts = {
          highlight = highlight,
          query = {
            -- html = "rainbow-no-tags",
            -- vue = "rainbow-no-tags",
            -- tsx = "rainbow-parens",
          },
        },

        config = function(_, opts)
          dofile(vim.g.base46_cache .. "rainbowdelimiters")

          require("rainbow-delimiters.setup").setup(opts)
        end,
      },
    },

    opts = {
      scope = {
        show_start = false,
        show_end = false,
        highlight = highlight,
        include = {
          node_type = {
            lua = {
              "chunk",
              "do_statement",
              "while_statement",
              "repeat_statement",
              "if_statement",
              "for_statement",
              "function_declaration",
              "function_definition",
              "table_constructor",
              "assignment_statement",
            },
            python = {
              -- run :InspectTree in a .py file to add more
              "if_statement",
              "for_statement",
              "while_statement",
              "try_statement",
              "with_statement",
              "function_definition",
              "class_definition",
              "decorated_definition",
              "match_statement",
              "expression",
              "argument_list",
              "tuple",
              "list",
              "dictionary",
              "set",
            },
            r = {

              "argument_list",
              "arguments",
              "function_definition",
              "if_statement",
              "for_statement",
              "while_statement",
              "repeat_statement",
              "braced_expression",
              "parenthesized_expression",
            },
          },
        },
      },
    },

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      -- disable indentation on the first level
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
}
