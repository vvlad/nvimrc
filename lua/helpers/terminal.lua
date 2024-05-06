local M = {}
local api = vim.api
local g = vim.g
local term = require "nvchad.term"

M.toggle = function(id, options)
  options = options or {}
  for _, opts in pairs(g.nvchad_terms) do
    pcall(api.nvim_win_close, opts.win, true)
  end

  term.toggle { id = tostring(id), pos = "sp", cmd = options.cmd }
end

return M
