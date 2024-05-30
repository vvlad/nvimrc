local M = {}
local logger = require "helpers.logger"

M.is_ruby_supported = function()
  logger.debug("Checking if Ruby is supported" ..
    tostring(vim.fn.executable "ruby") .. " " .. tostring(vim.fn.executable "npm"))
  return vim.fn.executable "ruby" == 1 and vim.fn.executable "npm" == 1
end

M.is_golang_supported = function()
  return vim.fn.executable "go" == 1 and vim.fn.executable "npm" == 1
end

M.is_lua_supported = function()
  return true
end

M.is_rust_supported = function()
  return vim.fn.executable "cargo" == 1 and vim.fn.executable "rustc" == 1
end

M.is_css_supported = function()
  return vim.fn.executable "npm" == 1
end

M.is_html_supported = function()
  return vim.fn.executable "npm" == 1
end

M.is_javascript_supported = function()
  return vim.fn.executable "npm" == 1
end

M.conditional_table = function(...)
  local entries = { ... }
  local result = {}
  for _, entry in pairs(entries) do
    local is_enabled = type(entry) == "table" and not entry.when or (entry.when and entry.when())
    if is_enabled then
      entry.when = nil
      for _, key in pairs(entry) do
        table.insert(result, key)
      end
    else
      if type(entry) == "string" then
        table.insert(result, entry)
      end
    end
  end
  logger.debug("Conditional table: " .. vim.inspect(result))
  return result
end

return M
