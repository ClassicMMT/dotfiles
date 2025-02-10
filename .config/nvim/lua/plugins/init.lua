return {
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- {
  --   "sphamba/smear-cursor.nvim",
  --   opts = {
  --     stiffness = 0.8,
  --     trailing_stiffness = 0.5,
  --     distance_stop_animating = 0.5,
  --   },
  -- },

  {
    "folke/twilight.nvim",
    event = { "BufReadPre", "BufNewfile" },
    opts = {
      dimming = {
        alpha = 0.5,
        color = { "Normal", "#ffffff" },
      },
    },
    -- -- runs twilight after loading
    -- config = function(_, opts)
    --   require("twilight").setup(opts)
    --   vim.cmd "Twilight"
    -- end,
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
    config = true,
  },

  {
    "ggandor/leap.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").add_default_mappings()
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
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}
