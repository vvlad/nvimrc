vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = "terminal"
  end,
})
