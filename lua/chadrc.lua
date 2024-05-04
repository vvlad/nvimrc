-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "kanagawa",

  cmp = {
    style = "flat_dark",
  },

  statusline = {
    theme = "vscode",
  },

  term = {
    hl = "Normal:Normal,Normal:Normal",
  },

  nvdash = {
    load_on_startup = true,
    header = { "                                            " },

    buttons = {
      { "  Find File", "", "Telescope find_files" },
      { "󰈚  Recent Files", "", "Telescope oldfiles" },
      { "󰈭  Find Word", "", "Telescope live_grep" },
      { "  Bookmarks", "", "Telescope marks" },
      { "  Themes", "", "Telescope themes" },
    },
  },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

return M
