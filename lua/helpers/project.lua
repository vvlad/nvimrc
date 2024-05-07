-- local g = vim.g
-- if not g.nvdash_shown then
--   g.nvdash_shown = true
--   if g.project_directory then
--     vim.defer_fn(function()
--       require("nvchad.nvdash").open()
--     end, 350)
--   end
-- end
local M = {}
local g = vim.g
local auto_tasks = require "helpers.auto-tasks"

M.is_project = function()
  return g.project_directory ~= nil
end

if M.is_project() and not g.project_initialized then
  g.project_initialized = true
  vim.defer_fn(function()
    auto_tasks.start()
    vim.cmd.wincmd "k"
    require("nvchad.nvdash").open()
    vim.cmd.wincmd "k"
    vim.cmd.stopinsert()
  end, 350)
end
