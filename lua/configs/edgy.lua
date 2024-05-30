local options = {
  close_when_all_hidden = false,
  options = {
    bottom = { size = 0.3 },
    left = { size = 30 },
    right = { size = 0.4 },
  },
  bottom = {
    {
      ft = "terminal",
      filter = function(buf)
        return vim.bo[buf].buftype == "terminal"
      end
    },
    "qf",
  },
  left = {
    "NvimTree",
  },
  right = {
    "help",
    "copilot-chat",
    "neotest-summary",
  },
  animate = {
    enabled = false,
  },
  wo = {
    winbar = false,
  },
  keys = {
    ["<ESC>"] = function(win)
      if vim.bo.filetype == "NvimTree" then
        return
      end
      win:close()
    end,
  },
}

return options
