local M = {}
local view = require "nvim-tree.view"

local exclude = {
  "NvimTree",
  "fzf",
  "help",
  "terminal",
  "copilot-chat",
}

local function usable_win_ids()
  local tabpage = vim.api.nvim_get_current_tabpage()
  local win_ids = vim.api.nvim_tabpage_list_wins(tabpage)
  local tree_winid = view.get_winnr(tabpage)

  return vim.tbl_filter(function(id)
    local bufid = vim.api.nvim_win_get_buf(id)
    for _, filetype in ipairs(exclude) do
      if vim.bo[bufid].filetype == filetype then
        return false
      end
    end

    local win_config = vim.api.nvim_win_get_config(id)
    return (id ~= tree_winid and win_config.focusable and not win_config.external) or false
  end, win_ids)
end

M.edit = function(path, focus)
  local actions = require "nvim-tree.actions"
  local win = usable_win_ids()
  local editor = require "edgy.editor"
  if vim.fn.isdirectory(path) == 1 then
    actions.finders.find_file.fn(path)
    editor.goto_main()
    return
  end
  actions.node.open_file.fn("", path)
  editor.goto_main()

  -- local buf = vim.api.nvim_get_current_buf()
  -- if #win == 0 then
  --   vim.api.nvim_command "vnew"
  --   vim.cmd.edit(path)
  -- else
  --   vim.api.nvim_set_current_win(win[1])
  --   vim.api.nvim_win_set_buf(win[1], buf)
  -- end

  if focus and vim.g.neovide then
    vim.cmd [[NeovideFocus]]
  end
end

return M
