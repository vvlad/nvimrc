local M = {}
local api = vim.api
local g = vim.g
local term = require "nvchad.term"
local logger = require "helpers.logger"

local function fix_term_highlight()
  vim.wo.winhighlight = "Normal:Normal"
end
local group = vim.api.nvim_create_augroup("TerminalFixes", {})
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = group,
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
    vim.bo.buflisted = false
    vim.bo.filetype = "terminal"
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
