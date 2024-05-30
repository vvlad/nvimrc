local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.tf",
  command = "set filetype=terraform",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.tfvars",
  command = "set filetype=terraform",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.tfstate",
  command = "set filetype=json",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.tfstate.backup",
  command = "set filetype=json",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.hcl",
  command = "set filetype=hcl",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.yml.erb",
  command = "set filetype=yaml",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.yaml.erb",
  command = "set filetype=yaml",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.ejson",
  command = "set filetype=json",
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "*.text.erb",
  command = "set filetype=text",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".gitlab*",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  pattern = "Guardfile",
  command = "set filetype=ruby",
})
