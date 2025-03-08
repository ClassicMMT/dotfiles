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
    local iron = require "iron.core"
    local view = require "iron.view"

    iron.setup {
      config = {
        highlight_last = false,
        scratch_repl = true,
        -- repl_open_cmd = view.split.vertical.botright(0.5),
        repl_open_cmd = view.bottom(0.3),
        -- preferred = {
        --   python = "python"
        -- },
        repl_definition = {
          sh = { "zsh" },
          python = {
            -- command = { "python" },
            command = { "ipython" },
            -- run "pip install ptpython" - otherwise, use the line above
            -- command = { "ptpython", "--vi" },
            format = require("iron.fts.common").bracketed_paste,
          },
        },
      },

      keymaps = {
        -- send_motion = "<leader>sc",
        -- visual_send = "<leader>sc",
        visual_send = "<CR>",
        send_file = "<leader>sf",
        -- send_line = "<leader>sl",
        send_line = "<CR>",
        send_until_cursor = "<leader>su",
        -- send_mark = "<leader>sm",
        -- mark_motion = "<leader>mc",
        -- mark_visual = "<leader>mc",
        -- remove_mark = "<leader>md",
        -- cr = "<leader>s<cr>",
        interrupt = "<leader>s<leader>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
      highlight = {
        bold = true,
      },
      ignore_blank_lines = true,
    }
  end,
}
