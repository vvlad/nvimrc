-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local api = vim.api
local btn = require("nvchad.tabufline.utils").btn

local function nvim_tree_width()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

local function txt(str, hl)
  str = str or ""
  local a = "%#" .. hl .. "#" .. str
  return a
end

local function btn(str, hl, func, arg)
  str = hl and txt(str, hl) or str
  arg = arg or ""
  return "%" .. arg .. "@" .. func .. "@" .. str .. "%X"
end

vim.cmd [[
function! NeoTestToggle(a,b,c,d)
  lua require("neotest").summary.toggle()
endfunction
]]

vim.api.nvim_create_user_command("NeoTestToggle", function()
  pcall(require("neotest").summary.toggle)
end, { nargs = 0 })
vim.api.nvim_create_user_command("NeoTestRunAll", function()
  require("neotest").run.run { suite = true }
end, { nargs = 0 })

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
      title = function()
        local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local len = nvim_tree_width()
        title = "  " .. title .. string.rep(" ", nvim_tree_width())
        return "%#NvimTreeRootFolder#" .. string.sub(title, 1, len)
      end,
      tests = function()
        local runall = btn(" 󱇯 ", "DiagnosticHint", "NeoTestToggle")
        return runall
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
    load_on_startup = false, -- vim.g.project_directory or false,
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
