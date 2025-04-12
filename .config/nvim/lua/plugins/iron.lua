return {
  "Vigemus/iron.nvim",
  cmd = { "IronRepl" },
  ft = { "python" },
  -- keys = {
  --   { "<leader>rs", "<cmd>IronRepl<CR>", desc = "Start iron" },
  --   { "<leader>rr", "<cmd>IronRestart<CR>", desc = "Restart iron" },
  --   { "<leader>rf", "<cmd>IronFocus<CR>", desc = "Focus iron" },
  --   { "<leader>rh", "<cmd>IronHide<CR>", desc = "Hide iron" },
  -- },
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
              -- "--color-info", -- deprecated
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

    -- general mappings
    local map = vim.keymap.set

    map("n", "<leader>rs", "<cmd>IronRepl<CR>", { desc = "Start iron" })
    map("n", "<leader>rr", "<cmd>IronRestart<CR>", { desc = "Restart iron" })
    map("n", "<leader>rf", "<cmd>IronFocus<CR>", { desc = "Focus iron" })
    map("n", "<leader>rh", "<cmd>IronHide<CR>", { desc = "Hide iron" })

    -- functions for sanity

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

    -- function for finding and moving to the next non-blank line
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

    local function is_allowed_type(type)
      local allowed_types = {
        "expression_statement",
        "function_definition",
        "class_definition",
        "if_statement",
        "for_statement",
        "while_statement",
      }
      for _, v in ipairs(allowed_types) do
        if v == type then
          return true
        end
      end
      return false
    end

    local function find_top_level_allowed_node(node)
      local parent = node:parent()
      local highest_node = nil
      while parent do
        local node_type = node:type()
        -- print(node_type, is_allowed_type(node_type))
        if is_allowed_type(node_type) then
          highest_node = node
        end
        node = parent
        parent = node:parent()
      end
      return highest_node
    end

    -- function for finding and selecting an expression statement
    -- to be used in before call_with_fallback(core.visual_send, FALLBACK)
    local function get_top_level_node_range()
      -- nothing
      local utils = require "nvim-treesitter.ts_utils"
      local node = utils.get_node_at_cursor()

      -- find the top-level node
      local top_level_node = find_top_level_allowed_node(node)
      if top_level_node then
        return true, { top_level_node:range() }
      else
        return false, nil
      end

      -- while node do
      --   local node_type = node:type()
      --   if
      --     node_type == "expression_statement"
      --     or node_type == "function_definition"
      --     or node_type == "class_definition"
      --   then
      --     -- get node range
      --     return true, { node:range() }
      --   end
      --   -- move to parent node
      --   node = node:parent()
      -- end
      -- -- top node is not an expression statement
      -- return false
    end

    local function visual_select_range(range)
      -- local unpack = unpack or table.unpack
      local start_row, start_col, end_row, end_col = unpack(range)
      -- set visual selection range
      vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
      vim.cmd "normal! v"
      -- end_col needs to be adjusted, otherwise it selects one too many
      vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col - 1 })
      -- expression statement found
      return true
    end

    local function get_cursor_position()
      -- returns the position of the cursor
      return vim.api.nvim_win_get_cursor(0)
    end

    local function restore_cursor_position(row, column)
      vim.api.nvim_win_set_cursor(0, { row, column })
    end

    map("n", "<CR>", function()
      local found, range = get_top_level_node_range()
      if found then
        -- save the cursor position
        local cursor_row, cursor_column = unpack(get_cursor_position())
        visual_select_range(range)
        call_with_fallback(core.visual_send)
        restore_cursor_position(cursor_row, cursor_column)
      else
        call_with_fallback(core.send_line)
      end
    end, { noremap = true, silent = true })

    map("n", "<S-CR>", function()
      local found, range = get_top_level_node_range()
      if found then
        visual_select_range(range)
        call_with_fallback(core.visual_send, "<S-CR>")
      else
        call_with_fallback(core.send_line)
      end
      move_to_next_non_blank_line()
    end, { noremap = true, silent = true })

    map("v", "<CR>", function()
      call_with_fallback(core.visual_send)
    end, { noremap = true, silent = true })

    map("v", "<S-CR>", function()
      call_with_fallback(core.visual_send, "<S-CR>")
      move_to_next_non_blank_line(vim.fn.getpos("'>")[2])
    end, { noremap = true, silent = true })
  end,
}
