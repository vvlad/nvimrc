local function ensure_cspell_json(path)
  local template = '{"version":"0.2","language":"en","flagWords":[],"words":[]}'
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({ template }, path)
  end
  return path
end

local function cspell_config_path(cwd)
  if vim.fn.isdirectory(vim.g.project_root .. "/.nvim") == 1 then
    return ensure_cspell_json(vim.g.project_root .. "/.nvim/cspell.json")
  end
  if vim.fn.isdirectory(cwd .. "/.nvim") == 1 then
    return ensure_cspell_json(cwd .. "/.nvim/cspell.json")
  end
  return ensure_cspell_json(vim.fn.stdpath "config" .. "/cspell.json")
end

return {
  lsp = {
    lua_ls = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
    "ruby_lsp",
    "tsserver",
    "tailwindcss",
    "cssls",
    "html",
    "gopls",
    "yamlls",
    "gitlab_ci_ls",
  },
  cspell = {
    config_file_preferred_name = "cspell.json",
    find_json = cspell_config_path,
  },
}
