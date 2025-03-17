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

    local function call_with_fallback(f, fallback)
      -- safely call f
      local status, _ = pcall(f)
      -- if the call fails, then simulate a standard CR press
      if not status then
        -- "\r" is the <CR> key
        -- vim.api.nvim_feedkeys(fallback or "\r", "n", true)
        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(fallback or "<CR>", true, false, true), "n", true)
      end
    end

    local function move_to_next_non_blank_line(end_line)
      local line_number = end_line or vim.fn.line "."
      local line_count = vim.api.nvim_buf_line_count(0)
      -- local buf = vim.api.nvim_get_current_buf()

      line_number = line_number + 1
      -- if the line is empty or a comment, find the next line
      while line_number <= line_count do
        local line = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
        if line:match "%S" and not line:match "^%s*#" then
          vim.api.nvim_win_set_cursor(0, { line_number, 0 })
          return
        end
        line_number = line_number + 1
      end
    end

    map("n", "<CR>", function()
      call_with_fallback(core.send_line)
    end, { noremap = true, silent = true })

    map("v", "<CR>", function()
      call_with_fallback(core.visual_send)
    end, { noremap = true, silent = true })

    map("n", "<S-CR>", function()
      call_with_fallback(core.send_line, "<S-CR>")
      move_to_next_non_blank_line()
    end, { noremap = true, silent = true })

    map("v", "<S-CR>", function()
      call_with_fallback(core.visual_send, "<S-CR>")
      move_to_next_non_blank_line(vim.fn.getpos("'>")[2])
      -- move_to_next_non_blank_line()
    end, { noremap = true, silent = true })
  end,
}
