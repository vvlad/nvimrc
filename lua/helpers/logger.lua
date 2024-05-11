local M = {}

local function log(message)
  local path = vim.fn.stdpath "data" .. "/nvim.log"
  local file = io.open(path, "a")

  assert(file ~= nil, "Failed to open log file: " .. path)

  file:write(message .. "\n")
  file:close()
end

local levels = { "trace", "debug", "info", "warn", "error" }
for _, level in ipairs(levels) do
  M[level] = function(message)
    log("[" .. level:upper() .. "] " .. message)
  end
end

return M
