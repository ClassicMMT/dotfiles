return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    -- brew install deno
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup {
        auto_load = true,
        close_on_bdelete = true,
        syntax = true, -- may impact performance
        theme = "dark",
        update_on_change = true,
        app = "webview", -- webview or browser
        filetype = { "markdown", "rmd", "tex" },
        throttle_at = 200000,
        throttle_time = "auto",
      }
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

      local map = vim.keymap.set
      map("n", "<leader>po", "<CMD>PeekOpen<CR>", {})
    end,
  },

  {
    "gbprod/cutlass.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {

      cut_key = "m",
      -- keys used  by flash.nvim
      exclude = { "ns", "nS" },
    },
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    config = function()
      require("telescope").load_extension "frecency"
      require("frecency.config").setup {
        auto_validate = true,
        ignore_patterns = { "*/.git", "*/.git/*", "*/.DS_Store" },
      }
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- q, p, d, c labels removed
      labels = "asfghjklwertuiozxvbnm",
      highlight = {
        backdrop = false, -- stops the screen greying out when flash is used with "s"
      },
      modes = {
        char = {
          enabled = true,
          multi_line = false,
          jump_labels = false,
          label = { exclude = "hjkliadcr" },
          highlight = { backdrop = false },
          -- jump = {
          --   autojump = true,
          -- },
          autohide = true,
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
    "andymass/vim-matchup",
    event = "BufReadPre",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>mt", "<cmd>MaximizerToggle<CR>", desc = "Maximizer" .. " Split maximiser toggle" },
    },
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
