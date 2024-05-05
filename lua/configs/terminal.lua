vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
    vim.bo.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.bo.filetype = "terminal"
    vim.bo.buflisted = false
  end,
})
