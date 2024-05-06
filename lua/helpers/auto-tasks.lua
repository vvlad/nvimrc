local root = vim.g.project_directory
if not root then
  return
end

local auto_tasks_path = root .. "/.nvim/auto-tasks.lua"

if vim.fn.filereadable(auto_tasks_path) == 0 then
  return
end

local tasks = loadfile(auto_tasks_path)()

if not tasks then
  return
end

local map = vim.keymap.set
local term = require "helpers.terminal"
local started = {}

for _, task in pairs(tasks) do
  if type(task) == "string" then
    task = { cmd = task }
  end
  task.id = "auto-task-" .. tostring(#started + 1)

  map({ "t" }, task.map or string.format("<A-%s>", task.id), function()
    term.toggle(task.id, { cmd = task.cmd })
  end)
  table.insert(started, task)
end

vim.defer_fn(function()
  for _, task in pairs(started) do
    term.toggle(task.id, { cmd = task.cmd })
  end
end, 300)
