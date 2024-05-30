local M = {}
local logger = require "helpers.logger"

M.root = nil
M.exclude_dirs = { "node_modules", ".git", ".cache", ".venv", ".vscode", ".github", ".asdf", "gems" }

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

  for _, excluded in pairs(M.exclude_dirs) do
    if string.find(M.root, excluded) then
      directory = nil
      break
    end
  end

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
  require "configs.filetypes"
  if M.root ~= nil then
    initialize_nvimtree()

    local auto_tasks = require "helpers.auto-tasks"

    vim.defer_fn(function()
      auto_tasks.start()
      vim.cmd.wincmd "k"
      vim.cmd.stopinsert()
      require("nvchad.nvdash").open()

      vim.api.nvim_create_autocmd({ "BufHidden", "BufLeave", "BufDelete" }, {
        callback = require("helpers.project").ensure_buffer_open,
      })
    end, 350)
  end
end

M.ensure_buffer_open = function()
  if not M.is_project() then
    return
  end

  local buffers = vim.tbl_filter(function(buf)
    return vim.fn.buflisted(buf) == 1
  end, vim.api.nvim_list_bufs())

  logger.debug("Opening project buffer" .. vim.inspect(buffers))
  if #buffers == 0 then
    vim.cmd.enew()
  end
end

return M
