local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    eruby = { "htmlbeautifier" },
    html = { "htmlbeautifier" },
    css = { { "prettierd", "prettier" } },
    scss = { { "prettierd", "prettier" } },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
