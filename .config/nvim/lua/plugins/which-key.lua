return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = function()
    dofile(vim.g.base46_cache .. "whichkey")

    -- don't show which-key for marks
    return {
      plugins = {
        marks = false,
      },
    }
  end,
}
