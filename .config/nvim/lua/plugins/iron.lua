return {
  "Vigemus/iron.nvim",
  cmd = { "IronRepl" },
  keys = {
    { "<leader>rs", "<cmd>IronRepl<CR>", desc = "Start iron" },
    { "<leader>rr", "<cmd>IronRestart<CR>", desc = "Restart iron" },
    { "<leader>rf", "<cmd>IronFocus<CR>", desc = "Focus iron" },
    { "<leader>rh", "<cmd>IronHide<CR>", desc = "Hide iron" },
  },
  config = function()
    local core = require "iron.core"
    local view = require "iron.view"

    core.setup {
      config = {
        close_window_on_exit = true,
        highlight_last = false,
        scratch_repl = true,
        repl_open_cmd = view.split.vertical.botright(0.3),
        -- repl_open_cmd = view.bottom(0.3),
        -- preferred = {
        --   python = "python"
        -- },
        repl_definition = {
          sh = { "zsh" },
          python = {
            -- command = { "python" },
            command = {
              "ipython",
              "--no-autoindent",
              "--colors=linux", -- NoColor, Neutral, Linux, or LightBG
              "--no-confirm-exit",
              "--color-info",
            },
            -- run "pip install ptpython" - otherwise, use the line above
            -- command = { "ptpython", "--vi" },
            format = require("iron.fts.common").bracketed_paste,
          },
        },
      },

      keymaps = {
        -- send_motion = "<leader>sc",
        -- visual_send = "<leader>sc",
        visual_send = "<leader>sl",
        send_file = "<leader>sf",
        -- send_line = "<leader>sl",
        send_line = "<leader>sl",
        send_until_cursor = "<leader>su",
        -- send_mark = "<leader>sm",
        -- mark_motion = "<leader>mc",
        -- mark_visual = "<leader>mc",
        -- remove_mark = "<leader>md",
        -- cr = "<leader>s<cr>",
        interrupt = "<leader>ri",
        exit = "<leader>rq",
        clear = "<leader>cl",
      },
      highlight = {
        bold = true,
      },
      ignore_blank_lines = true,
    }

    -- make the CR mapping function properly
    local map = vim.keymap.set

    map("n", "<CR>", function()
      -- safely call core.send_line
      local status, _ = pcall(core.send_line)
      -- if the call fails, then simulate a standard CR press
      if not status then
        -- "\r" is the <CR> key
        vim.api.nvim_feedkeys("\r", "n", true)
        -- return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
      end
    end, { noremap = true, silent = true })

    map("v", "<CR>", function()
      local status, _ = pcall(core.visual_send)
      if not status then
        vim.api.nvim_feedkeys("\r", "n", true)
        -- return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
      end
    end, { noremap = true, silent = true })
  end,
}
