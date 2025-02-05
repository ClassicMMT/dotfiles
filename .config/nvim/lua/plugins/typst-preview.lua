return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  -- opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  config = function()
    local typst = require "typst-preview"
    typst.setup {
      invert_colors = "auto",
    }

    -- keymaps
    local map = vim.keymap.set
    map("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", { desc = "Typst Preview Toggle" })
  end,
}
