-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local api = vim.api

local function nvim_tree_width()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

M.ui = {
  theme = "vscode_dark",

  cmp = {
    style = "flat_dark",
  },

  tabufline = {
    lazyload = false,
    order = { "title", "buffers", "tabs", "btns" },
    modules = {
      title = function()
        local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local len = nvim_tree_width()
        title = "  " .. title .. string.rep(" ", nvim_tree_width())
        return "%#NvimTreeRootFolder#" .. string.sub(title, 1, len)
      end,
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
