require "nvchad.options"

local o = vim.o
local g = vim.g

o.cmdheight = 0
o.linespace = 0
o.whichwrap = "<,>,[,]"

o.expandtab = true
o.autoindent = true
o.smartindent = true
o.shiftround = true
o.wrap = false

o.joinspaces = true

o.splitright = true
o.splitbelow = true

o.smartcase = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true

o.hidden = true
o.colorcolumn = "120"

if g.neovide then
  o.guifont = "JetBrainsMonoNL Nerd Font Mono:h11"

  g.neovide_refresh_rate = 90
  g.neovide_transparency = 1
  g.neovide_refresh_rate_idle = 1

  g.neovide_cursor_antialiasing = true
  g.neovide_cursor_trail_size = 0.2
  g.neovide_cursor_animation_length = 0.01
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_cursor_animate_in_insert_mode = true

  g.neovide_cursor_animate_command_line = false
  g.neovide_scroll_animation_length = 0.1
  g.neovide_input_use_logo = 1

  vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<C-S-v>", function()
    vim.api.nvim_paste(vim.fn.getreg "+", true, -1)
  end, { noremap = true, silent = true })
end

-- local autocmd = vim.api.nvim_create_autocmd
--
-- autocmd("BufReadPost", {
--   pattern = "*",
--   callback = function()
--     local line = vim.fn.line "'\""
--     if
--       line > 1
--       and line <= vim.fn.line "$"
--       and vim.bo.filetype ~= "commit"
--       and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
--     then
--       vim.cmd 'normal! g`"'
--     end
--   end,
-- })
