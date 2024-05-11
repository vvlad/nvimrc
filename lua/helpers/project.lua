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
local editor = require "edgy.editor"

M.is_project = function()
  return g.project_directory ~= nil
end

local function open_project_root(file)
  local lspconfig = require "lspconfig"
  local directory = lspconfig.util.find_git_ancestor(file)

  if not directory then
    if vim.fn.isdirectory(file) == 1 then
      directory = file
    else
      return
    end
  end

  vim.cmd.cd(directory)

  require("nvim-tree.api").tree.open {
    path = vim.g.project_directory,
    current_window = false,
    focus = false,
  }

  vim.defer_fn(function()
    vim.cmd "wincmd l"
  end, 150)
end

if M.is_project() and not g.project_initialized then
  g.project_initialized = true

  open_project_root(vim.g.project_directory)
  vim.defer_fn(function()
    auto_tasks.start()
    editor.goto_main()
    vim.cmd.wincmd "k"
    require("nvchad.nvdash").open()
    --    vim.cmd.wincmd "k"
    vim.cmd.stopinsert()
  end, 350)
end
