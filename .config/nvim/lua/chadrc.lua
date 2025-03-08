-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.mason = {
  cmd = true,
  pkgs = {
    -- "mypy",
    "debugpy",
  },
}

M.ui = {
  -- disable tabufline
  tabufline = {
    enabled = false,
  },

  statusline = {
    -- theme = minimal, separator = round is very nice, if no artifacts
    theme = "minimal",
    separator_style = "round",
  },
}

M.base46 = {
  theme = "onedark",
  transparency = true,

  integrations = {
    "rainbowdelimiters",
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    LspInlayHint = {
      fg = "#4f4f4f",
      bg = "NONE",
      italic = true,
    },
  },
}

return M
