local options = {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    autocmd = false,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "ruby",
    "javascript",
    "hcl",
    "terraform",
  },
}

return options
