local M = {}
local function ensure_cspell_json(path)
  local template = '{"version":"0.2","language":"en","flagWords":[],"words":[]}'
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({ template }, path)
  end
  return path
end

M.config_path = function(cwd)
  if vim.g.project_root and vim.fn.isdirectory(vim.g.project_root .. "/.nvim") == 1 then
    return ensure_cspell_json(vim.g.project_root .. "/.nvim/cspell.json")
  end
  if vim.fn.isdirectory(cwd .. "/.nvim") == 1 then
    return ensure_cspell_json(cwd .. "/.nvim/cspell.json")
  end
  return ensure_cspell_json(vim.fn.stdpath "config" .. "/cspell.json")
end

return M
