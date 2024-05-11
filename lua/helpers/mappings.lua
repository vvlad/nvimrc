local M = {}
local logger = require "helpers.logger"
local helpers = require "helpers"

M.setup = function(opts)
  local actions = require "helpers.actions"
  local mappings = {}

  for _, options in pairs(opts) do
    local shortcut = table.remove(options, 1)
    local action = table.remove(options, 1)
    local except = options.except
    local modes = actions.except_modes(except)
    local mapper = options.where or M.map

    mappings[mapper] = mappings[mapper] or {}
    options.except = nil
    options.only = nil
    options.where = nil

    table.insert(mappings[mapper], {
      modes = modes,
      shortcut = shortcut,
      action = action,
      options = options,
    })
  end

  for mapper, definitions in pairs(mappings) do
    mapper(definitions)
  end
end

M.map = function(actions, options)
  options = options or {}
  local map = vim.keymap.set
  for _, action in pairs(actions) do
    map(action.modes, action.shortcut, action.action, helpers.table.merge(options, action.options))
  end
end

return M
