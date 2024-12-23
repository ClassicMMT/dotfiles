return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 		  "vim", "lua", "vimdoc",
  --       -- "html", "css", "bash",
  --       "markdown", "json", "zsh",
  --       "gitignore", "python", "r",
  -- 		},
  -- 	},
  --
  --   indent =  { enable = true, },
  --
  --   highlight = {
  --     enable = true,
  --     use_languagetree = true,
  --   },
  --
  -- },

  -- CUSTOM
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better-escape").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local nvimtree = require("nvim-tree")

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup({
        actions = {
          open_file = {
            quit_on_open = true,
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".DS_Store", },
        },
      })
    end,
  },
}
