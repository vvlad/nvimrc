local options = {
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
    find_json = require("helpers.cspell").config_path,
  },
}

return options
