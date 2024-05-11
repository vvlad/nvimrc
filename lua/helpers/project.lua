local M = {}

M.root = nil

M.setup = function()
  local path = vim.fn.expand "%"
  if vim.fn.isdirectory(path) == 1 then
    M.root = path
    vim.cmd.cd(path)
    vim.cmd.bd()
    vim.bo.readonly = true
    vim.bo.modifiable = false
    vim.bo.buflisted = false
  end
end

M.is_project = function()
  return M.root ~= nil
end

local function initialize_nvimtree()
  local lspconfig = require "lspconfig"
  local directory = lspconfig.util.find_git_ancestor(M.root)

  if not directory then
    if vim.fn.isdirectory(M.root) == 1 then
      directory = M.root
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
end

M.initialize = function()
  if M.root ~= nil then
    initialize_nvimtree()

    local auto_tasks = require "helpers.auto-tasks"

    vim.defer_fn(function()
      auto_tasks.start()
      vim.cmd.wincmd "k"
      vim.cmd.stopinsert()
      require("nvchad.nvdash").open()
    end, 350)
  end
end

return M
