vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },

  -- ADD CUSTOM PLUGINS HERE OR IN THE PLUGINS FOLDER
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Alacritty - fix padding issues

local alacrittyAutoGroup = vim.api.nvim_create_augroup("alacritty", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = alacrittyAutoGroup,
  callback = function()
    local options = {
      "window.padding.x=0",
      "window.padding.y=0",
      "window.dynamic_padding=true",
      "font.offset.x=0",
      "font.offset.y=5",
    }

    vim.fn.system(
      "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options "
        .. "'"
        .. table.concat(options, "' '")
        .. "'"
    )
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = alacrittyAutoGroup,
  callback = function()
    vim.fn.jobstart("alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r", { detach = true })
  end,
})
