local function fix_term_highlight()
  local win = vim.api.nvim_get_current_win()
  vim.wo[win].winhighlight = "Normal:Normal"
end

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.defer_fn(fix_term_highlight, 5)
  end,
})

return {
  close_when_all_hidden = false,
  options = {
    bottom = { size = 0.3 },
    left = { size = 30 },
    right = { size = 0.4 },
  },
  bottom = {
    "terminal",
  },
  left = {
    "NvimTree",
  },
  right = {
    "help",
  },
  animate = {
    enabled = false,
  },
  wo = {
    winbar = false,
  },
  keys = {
    ["<ESC>"] = function(win)
      win:close()
    end,
  },
}
