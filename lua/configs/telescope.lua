local defaults = require "nvchad.configs.telescope"
local helpers = require "helpers"

local function open_file()
  local file = require "helpers.file"
  --
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry()
  local filename
  if entry.path or entry.filename then
    filename = entry.path or entry.filename
  end

  if filename then
    file.edit(filename)
  end
end

local config = {
  defaults = {
    mappings = {
      n = {
        ["<CR>"] = open_file,
      },
      i = {
        ["<CR>"] = open_file,
      },
    },

    file_ignore_patterns = { "node_modules", "log", "dist", ".git", "\\.nvim" },
  },
}

config = helpers.table.merge(defaults, config)
return config
