local M = {}
local map = vim.keymap.set
local project = require "helpers.project"

M.available = function()
  if not project.root then
    return false
  end

  return M.auto_tasks_path() ~= nil
end

M.auto_tasks_path = function()
  if not project.root then
    return
  end

  local auto_tasks_path = project.root .. "/.nvim/auto-tasks.lua"
  if vim.fn.filereadable(auto_tasks_path) == 0 then
    return
  end
  return auto_tasks_path
end

M.project_tasks = function()
  local auto_tasks_path = M.auto_tasks_path()
  if not auto_tasks_path then
    return {}
  end
  local loader = loadfile(auto_tasks_path)
  if not loader then
    return {}
  end

  local tasks = loader()
  local defined = {}
  for _, task in pairs(tasks) do
    if type(task) == "string" then
      task = { cmd = task }
    end
    task.id = "auto-task-" .. tostring(#defined + 1)
    task.map = task.map or string.format("<A-%s>", #defined + 1)
    table.insert(defined, task)
  end

  return defined
end

M.start = function()
  local term = require "helpers.terminal"
  for _, task in pairs(M.project_tasks()) do
    map({ "t" }, task.map, function()
      term.toggle(task.id, { cmd = task.cmd })
    end)
    term.toggle(task.id, { cmd = task.cmd })
  end
end

return M
