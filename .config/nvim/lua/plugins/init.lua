return {
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },

  {
    "gbprod/cutlass.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      cut_key = "m",
      exclude = { "ns", "nS" },
    },
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- q and p labels removed
      labels = "asdfghjklwertyuiozxcvbnm",
      modes = {
        char = {
          -- enabled = false,
          -- multiline = false,
          jump_labels = true,
          -- jump = {
          --   autojump = true,
          -- },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>mt", "<cmd>MaximizerToggle<CR>", desc = "Maximizer" .. " Split maximiser toggle" },
    },
  },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    -- config = true,
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          -- keymaps changed to play better with flash.nvim
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          -- normal = "ys",
          normal = "<leader>s",
          -- normal_cur = "yss",
          normal_cur = "<leader>ss",
          -- normal_line = "yS",
          normal_line = "<leader>S",
          -- normal_cur_line = "ySS",
          normal_cur_line = "<leader>SS",
          -- visual = "S",
          visual = "<leader>s",
          -- visual_line = "gS",
          visual_line = "<leader>S",
          -- delete = "ds",
          delete = "<leader>ds",
          -- change = "cs",
          change = "<leader>cs",
          -- change_line = "cS",
          change_line = "<leader>cS",
        },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}
