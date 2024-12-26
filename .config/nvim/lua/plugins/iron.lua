return {
  "Vigemus/iron.nvim",
  cmd = { "IronRepl" },
  keys = {
    { "<leader>rs", "<cmd>IronRepl<CR>",    desc = "Start iron" },
    { "<leader>rr", "<cmd>IronRestart<CR>", desc = "Restart iron" },
    { "<leader>rf", "<cmd>IronFocus<CR>",   desc = "Focus iron" },
    { "<leader>rh", "<cmd>IronHide<CR>",    desc = "Hide iron" },
  },
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_open_cmd = view.split.vertical.botright(0.5),
        -- preferred = {
        --   python = "python"
        -- },
        repl_definition = {
          python = {
            command = { "python" },
          },
        },
      },

      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_until_cursor = "<leader>su",
        send_mark = "<leader>sm",
        -- mark_motion = "<leader>mc",
        -- mark_visual = "<leader>mc",
        -- remove_mark = "<leader>md",
        cr = "<leader>s<cr>",
        interrupt = "<leader>s<leader>",
        exit = "<leader>sq",
        clear = "<leader>cl",

      },
      highlight = {
        bold = true,
      },
      ignore_blank_lines = true,

    })
  end,
}
