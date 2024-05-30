local helpers = require "helpers.lsp"

local options = {
  lsp = helpers.conditional_table(
    {
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
    },
    { "ruby_lsp", when = helpers.is_ruby_supported },
    { "tsserver", when = helpers.is_javascript_supported },
    { "tailwindcss", "cssls", when = helpers.is_css_supported },
    { "html", when = helpers.is_html_supported },
    { "gopls", when = helpers.is_golang_supported },
    { "yamlls", when = helpers.is_javascript_supported }
  ),
  cspell = {
    config_file_preferred_name = "cspell.json",
    find_json = require("helpers.cspell").config_path,
  },
}

return options
