return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require "nvim-tree"

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup {
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".DS_Store" },
      },
      notify = {
        -- diable information messages
        threshold = vim.log.levels.WARN,
      },
    }
  end,
}
