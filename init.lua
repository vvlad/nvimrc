vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

if vim.fn.isdirectory(vim.fn.expand "%") == 1 then
  vim.g.project_directory = vim.fn.expand "%"
  vim.cmd.cd(vim.g.project_directory)
  vim.cmd.bd()
  local current_buffer = vim.api.nvim_get_current_buf()
  vim.bo[current_buffer].readonly = true
  vim.bo[current_buffer].modifiable = false
  vim.bo[current_buffer].buflisted = false
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
  require "configs.terminal"
  require "helpers.auto-tasks"
end)
