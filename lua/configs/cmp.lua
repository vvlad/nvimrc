local options = require "nvchad.configs.cmp"
local lspkind = require "lspkind"
lspkind.init {
  symbol_map = {
    Copilot = "",
  },
}

options.formatting = {
  format = lspkind.cmp_format {
    mode = "symbol",
    maxwidth = 50,
    ellipsis_char = "...",
    show_labelDetails = true,
    symbol_map = { Copilot = "" },
  },
}

options.sources = {
  { name = "copilot", group_index = 2, keyword_length = 0, priority = 0 },
  { name = "nvim_lsp", group_index = 2 },
  { name = "luasnip", group_index = 2 },
  { name = "buffer", group_index = 2 },
  { name = "nvim_lua", group_index = 2 },
  { name = "path", group_index = 2 },
}

return options
