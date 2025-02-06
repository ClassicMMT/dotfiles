return {
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },

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
