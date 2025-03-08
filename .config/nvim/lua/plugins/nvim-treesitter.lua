return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "gitignore",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "markdown",
      "python",
      "r",
      "rnoweb",
      "typescript",
      "typst",
      "vim",
      "vimdoc",
      "yaml",
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },

    -- indent = { enable = true, disable = { "python" } },
    indent = { enable = true },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    -- Configuration for nvim-treesitter-textobjects
    textobjects = {

      -- selects start with v. For example: va=
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- assignments
          ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
          ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
          ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
          ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

          -- -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
          -- ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
          -- ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
          -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
          -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

          -- arguments
          ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
          ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

          -- conditions
          ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
          ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

          -- loops
          ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
          ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

          -- functions
          ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
          ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

          ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
          ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
        },
      },
    },
  },
}
