local M = {}
local api = vim.api
local g = vim.g
local term = require "nvchad.term"

local function fix_term_highlight()
  vim.wo.winhighlight = "Normal:Normal"
end

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("TerminalFixes", {}),
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
    vim.bo.buflisted = false
    vim.defer_fn(fix_term_highlight, 5)
  end,
})

M.toggle = function(id, options)
  options = options or {}
  for _, opts in pairs(g.nvchad_terms) do
    pcall(api.nvim_win_close, opts.win, true)
  end

  term.toggle { id = tostring(id), pos = "sp", cmd = options.cmd }
end

return M
