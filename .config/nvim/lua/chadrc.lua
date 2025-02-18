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

    -- IblChar = { fg = "#0000ff" },
    -- IblScopeChar = { fg = "#00ff00" },
    -- indent-blankline
    -- ["@ibl.scope.underline.1"] = { bg = { "black", "red", 10 } },
    -- ["@ibl.scope.underline.2"] = { bg = { "black", "yellow", 10 } },
    -- ["@ibl.scope.underline.3"] = { bg = { "black", "blue", 10 } },
    -- ["@ibl.scope.underline.4"] = { bg = { "black", "orange", 10 } },
    -- ["@ibl.scope.underline.5"] = { bg = { "black", "green", 10 } },
    -- ["@ibl.scope.underline.6"] = { bg = { "black", "purple", 10 } },
    -- ["@ibl.scope.underline.7"] = { bg = { "black", "cyan", 10 } },
    -- ["@ibl.indent.char.1"] = { nocombine = true },
    -- ["@ibl.scope.char.1"] = { fg = "#777777", bg = "#151515", nocombine = true },
    -- ["@ibl.whitespace.char.1"] = { nocombine = true },
    -- ["@ibl.scope.underline.1"] = { sp = "#777777", underline = true },
  },
}

return M
