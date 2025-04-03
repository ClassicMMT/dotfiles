local unpack = unpack or table.unpack
-- Use "RMapsDesc" to get a list of all R keybindings
-- Use "RConfigShow" to see full config
-- all keymaps found here: https://github.com/R-nvim/R.nvim/blob/7b90a8898f88b71bcd3c8c19a05439398c421ac8/lua/r/maps.lua#L103

local function check_if_inside_r_chunk()
  -- returns true and coordinates if inside r chunk, otherwise returns false
  local cursor_row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local chunk_start_row, chunk_end_row
  local up_row, down_row = cursor_row, cursor_row
  local line_count = vim.api.nvim_buf_line_count(0)

  while not chunk_start_row and up_row > 0 do
    local line = vim.fn.getline(up_row)
    if line:match "^```{r.+" then
      chunk_start_row = up_row
    elseif line:match "^```$" and up_row ~= cursor_row then
      return { false }
    end
    up_row = up_row - 1
  end

  while not chunk_end_row and down_row < line_count do
    local line = vim.fn.getline(down_row)
    if line:match "^```{r.+" and down_row ~= cursor_row then
      return { false }
    elseif line:match "^```$" then
      chunk_end_row = down_row
    end
    down_row = down_row + 1
  end

  return { true, chunk_start_row, chunk_end_row }
end

local function visual_select_rows(start_row, end_row, cursor_column)
  -- set visual selection range
  vim.api.nvim_win_set_cursor(0, { start_row, cursor_column or 0 })
  vim.cmd "normal! V"
  vim.api.nvim_win_set_cursor(0, { end_row, cursor_column or 0 })
end

local function select_inside_chunk()
  local inside_chunk, chunk_start_row, chunk_end_row = unpack(check_if_inside_r_chunk())
  -- restores the cursor position
  local _, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  if inside_chunk then
    visual_select_rows(chunk_start_row + 1, chunk_end_row - 1, cursor_col)
    return true
  end
end

local function select_around_chunk()
  local inside_chunk, chunk_start_row, chunk_end_row = unpack(check_if_inside_r_chunk())
  -- restores the cursor position
  local _, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  if inside_chunk then
    visual_select_rows(chunk_start_row, chunk_end_row, cursor_col)
    return true
  end
end

local function change_inside_chunk()
  local status = select_inside_chunk()
  if status then
    -- vim.cmd "normal! c"
    -- vim.api.nvim_feedkeys("c", "n", true)
    vim.api.nvim_input "c"
  end
end

local function change_around_chunk()
  local status = select_around_chunk()
  if status then
    -- vim.cmd "normal! c"
    -- vim.api.nvim_feedkeys("c", "n", true)
    vim.api.nvim_input "c"
  end
end

local function delete_around_chunk()
  local inside_chunk, chunk_start_row, chunk_end_row = unpack(check_if_inside_r_chunk())
  if inside_chunk then
    vim.api.nvim_buf_set_lines(0, chunk_start_row - 1, chunk_end_row, false, {})
    vim.api.nvim_win_set_cursor(0, { chunk_start_row, 0 })
  end
end

local function delete_inside_chunk()
  local inside_chunk, chunk_start_row, chunk_end_row = unpack(check_if_inside_r_chunk())
  if inside_chunk then
    vim.api.nvim_buf_set_lines(0, chunk_start_row, chunk_end_row - 1, false, { "" })
    vim.api.nvim_win_set_cursor(0, { chunk_start_row + 1, 0 })
  end
end

local function find_argument_range()
  local utils = require "nvim-treesitter.ts_utils"
  local node = utils.get_node_at_cursor()

  -- find the parent argument node
  while node:type() ~= "argument" do
    if node:type() == "arguments" then
      -- edge case - cursor is in a space between arguments
      return { nil, nil, nil, nil }
    end
    node = node:parent()
  end

  local start_row, start_col, end_row, end_col = node:range()
  return { start_row + 1, start_col, end_row + 1, end_col }
end

local function select_range(start_row, start_col, end_row, end_col)
  vim.api.nvim_win_set_cursor(0, { start_row, start_col })
  vim.cmd "normal! v"
  vim.api.nvim_win_set_cursor(0, { end_row, end_col })
  return true
end

local function delete_inside_argument()
  local start_row, start_col, end_row, end_col = unpack(find_argument_range())
  if start_row then
    select_range(start_row, start_col, end_row, end_col - 1)
    vim.cmd "normal! d"
  end
end

local function change_inside_argument()
  local start_row, start_col, end_row, end_col = unpack(find_argument_range())
  if start_row then
    select_range(start_row, start_col, end_row, end_col - 1)
    vim.api.nvim_input "c"
  end
end

M = {
  "R-nvim/R.nvim",
  lazy = false,
  -- version = "~0.1.0",
  -- keys = keymaps,

  config = function()
    local opts = {
      hook = {
        on_filetype = function()
          vim.g.rout_follow_colorscheme = true

          local map = vim.api.nvim_buf_set_keymap
          local keymap = vim.keymap.set

          -- general
          map(0, "n", "<BS>rs", "<Plug>RStart", { desc = "Start R" })
          map(0, "n", "<BS>ro", "<Plug>ROBToggle", { desc = "Toggle object browser" })
          map(0, "n", "<BS>rh", "<Plug>RHelp", { desc = "Help" })
          map(0, "n", "<BS>re", "<Plug>RShowEx", { desc = "Show example" })
          map(0, "n", "<BS>ra", "<Plug>RShowArgs", { desc = "Show args" })
          map(0, "i", "__", "<Plug>RInsertAssign", {})
          map(0, "i", "++", "<Plug>RInsertPipe", {})

          -- send
          map(0, "n", "<Enter>", "<Plug>RSendLine", { desc = "Send line" })
          map(0, "n", "<S-Enter>", "<Plug>RDSendLine", { desc = "Send line and move" })
          map(0, "v", "<Enter>", "<Plug>RSendSelection", { desc = "Send selection" })
          map(0, "n", "<BS>sm", "<Plug>RSendCurrentFun", { desc = "Send current function" })
          map(0, "n", "<BS>Sm", "<Plug>RSendCurrentFun", { desc = "Send current function and move" })
          map(0, "n", "<BS>su", "<Plug>RSendAboveLines", { desc = "Send above lines" })
          map(0, "n", "<BS>sf", "<Plug>RSendFile", { desc = "Send file" })

          -- rmd
          map(0, "n", "<BS>sc", "<Plug>RSendChunk", { desc = "Send chunk" })
          map(0, "n", "<BS>sa", "<Plug>RSendChunkFH", { desc = "Run above chunks" })
          map(0, "n", "gn", "<Plug>RNextRChunk", { desc = "Next chunk" })
          map(0, "n", "gN", "<Plug>RPreviousRChunk", { desc = "Previous Chunk" })
          map(0, "n", "<BS>k", "<Plug>RMakeRmd", { desc = "Knit rmd" })

          -- action
          map(0, "n", "<BS>h", "<Cmd>lua require('r.run').action('head')<CR>", {})

          -- close device
          map(
            0,
            "n",
            "<BS>dc",
            "<Cmd>lua require('r.send').cmd('dev.off()')<CR>",
            { desc = "Close device", noremap = true }
          )
          map(0, "n", "<BS>rq", "<Plug>RClose", { desc = "Close R" })

          -- http device
          -- map(
          --   0,
          --   "n",
          --   "<LocalLeader>gd",
          --   "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>",
          --   { desc = "httpgd" }
          -- )

          -- custom mappings
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "rmd",
            callback = function()
              local opts = { noremap = true, silent = true, buffer = true }
              keymap("n", "vic", select_inside_chunk, opts)
              keymap("n", "vac", select_around_chunk, opts)
              keymap("n", "cic", change_inside_chunk, opts)
              keymap("n", "cac", change_around_chunk, opts)
              keymap("n", "dic", delete_inside_chunk, opts)
              keymap("n", "dac", delete_around_chunk, opts)
              keymap("n", "dia", delete_inside_argument, opts)
              keymap("n", "cia", change_inside_argument, opts)
            end,
          })
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
      user_maps_only = true, -- removes all default keybindings and keeps only user ones
      -- applescript = false,
      Rout_more_colors = true,
      objbr_allnames = false,
      objbr_auto_start = false,
      objbr_h = 10,
      objbr_opendf = false,
      objbr_openlist = false,
      -- objbr_place = "console,below",
      objbr_place = "console,above",
      pipe_version = "magrittr",
      pdfviewer = "",
      quarto_chunk_hl = {
        highlight = false, -- highlight code blocks
        yaml_hl = true, -- highlight yaml
        virtual_title = true,
        -- bg = "#003010",
        -- events = "BufEnter,TextChanged",
      },
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
