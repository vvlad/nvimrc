local M = {}

local function nvim_tree_width()
  local api = vim.api
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

vim.cmd [[
function! NeoTestToggle()
  lua require("neotest").summary.toggle()
endfunction
]]

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n lua require('edgy.editor').goto_main()\nexecute 'b'..a:bufnr \n endfunction"

M.title = function()
  local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local len = nvim_tree_width()
  title = "  " .. title .. string.rep(" ", nvim_tree_width())
  return "%#NvimTreeRootFolder#" .. string.sub(title, 1, len)
end

M.txt = function(str, hl)
  str = str or ""
  local a = "%#" .. hl .. "#" .. str
  return a
end

M.btn = function(str, hl, func, arg)
  str = hl and M.txt(str, hl) or str
  arg = arg or ""
  return "%" .. arg .. "@" .. func .. "@" .. str .. "%X"
end

M.tests = function()
  return M.btn(" 󱇯 ", "DiagnosticHint", "NeoTestToggle")
end

return M
