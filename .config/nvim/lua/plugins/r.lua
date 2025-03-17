local keymaps = {
  -- Use "RMapsDesc" to get a list of all R keybindings
  -- Use <localleader>ro to open object browser
  -- all keymaps found here: https://github.com/R-nvim/R.nvim/blob/7b90a8898f88b71bcd3c8c19a05439398c421ac8/lua/r/maps.lua#L103
  {
    "<BS>rs",
    function()
      require("r.run").start_R "R"
    end,
    desc = "Start R",
  },
  {
    "<BS>ro",
    function()
      require("r.browser").start()
    end,
    desc = "Toggle Object Browser",
  },
  {
    "<BS>rh",
    function()
      require("r.run").action "help"
    end,
    desc = "Help",
  },
  {
    "<BS>su",
    function()
      require("r.send").above_lines()
    end,
    desc = "Send Lines Above",
  },
  {
    "<BS>sf",
    function()
      require("r.send").source_file()
    end,
    desc = "Send File",
  },
}

M = {
  "R-nvim/R.nvim",
  lazy = false,
  version = "~0.1.0",
  -- branch = "feature/improve-chunk-handling",
  keys = keymaps,

  config = function()
    local opts = {
      hook = {
        on_filetype = function()
          local map = vim.api.nvim_buf_set_keymap
          -- send
          map(0, "n", "<Enter>", "<Plug>RSendLine", {})
          map(0, "n", "<S-Enter>", "<Plug>RDSendLine", {})
          map(0, "v", "<Enter>", "<Plug>RSendSelection", {})
          map(
            0,
            "n",
            "<LocalLeader>gd",
            "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>",
            { desc = "httpgd" }
          )
          -- rmd
          map(0, "n", "<BS>sc", "<Plug>RSendChunk", {})
          map(0, "n", "<BS>sa", "<CMD>lua require('r.send').chunks_up_to_here()<CR>", { desc = "Run Above Chunks" })

          -- close device
          map(0, "n", "<BS>wq", "<Cmd>lua require('r.send').cmd('dev.off()')<CR>", { noremap = true })
          -- close
          map(0, "n", "<BS>rq", "<CMD>lua require('r.run').quit_R('nosave')<CR>", { desc = "R Close" })
        end,
      },

      R_args = { "--quiet", "--no-save" },
      min_editor_width = 72,
      rconsole_width = 78,
      -- objbr_mappings = { -- Object browser keymap
      --   c = "class", -- Call R functions
      --   -- ["<localleader>gg"] = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
      --   v = function()
      --     -- Run lua functions
      --     require("r.browser").toggle_view()
      --   end,
      -- },
      disable_cmds = {
        "RClearConsole",
        "RCustomStart",
        "RSPlot",
        "RSaveClose",
      },

      -- My custom options

      auto_quit = true,
      silent_term = true,
      -- external_term = "kitty", -- linux only
      -- user_maps_only = true, -- removes all default keybindings and keeps only user ones
      -- applescript = true,
      applescript = false,
      Rout_more_colors = true,
      objbr_allnames = false,
      objbr_auto_start = false,
      objbr_h = 10,
      objbr_opendf = false,
      objbr_openlist = false,
      objbr_place = "console,below",
      assignment_keymap = "++",
      pipe_keymap = "--",
      pipe_version = "magrittr",
      pdfviewer = "",
    }

    if vim.env.R_AUTO_START == "true" then
      opts.auto_start = "on startup"
      opts.objbr_auto_start = true
    end
    require("r").setup(opts)
    require("cmp_r").setup {}

    vim.g.R_filetypes = {
      "r",
      "rmd",
      "rnoweb",
      "quarto",
      "rhelp",
    }
  end,
}

return M
