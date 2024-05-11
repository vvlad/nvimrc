-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}
local helper = require "helpers.nvchad"

M.ui = {
  theme = "vscode_dark",

  theme_toggle = {
    "vscode_dark",
    "flexoki-light",
  },

  cmp = {
    style = "flat_dark",
  },

  tabufline = {
    lazyload = false,
    order = { "title", "buffers", "tabs", "tests", "btns" },
    modules = {
      title = helper.title,
      tests = helper.tests,
    },
  },

  statusline = {
    theme = "vscode",
  },

  term = {
    hl = "Normal:Normal,Normal:Normal",
  },

  nvdash = {
    load_on_startup = false,
    header = { "                                            " },

    buttons = {
      { "  Find File", "", "Telescope find_files" },
      { "󰈚  Recent Files", "", "Telescope oldfiles" },
      {
        "󱇯  Test Suite",
        "",
        function()
          require("neotest").summary.toggle()
        end,
      },
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
