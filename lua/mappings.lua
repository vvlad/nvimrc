-- require "nvchad.mappings"

local map = vim.keymap.set

map({ "n", "v" }, "<C-Right>", "w")
map({ "n", "v" }, "<C-Left>", "b")

map("t", "<A-Down>", "<C-\\><C-n><C-w>j")
map("n", "<A-Down>", "<C-w>j")
map("i", "<A-Down>", "<ESC><C-w>j")

map("t", "<A-Up>", "<C-\\><C-n><C-w>k")
map("n", "<A-Up>", "<C-w>k")
map("i", "<A-Up>", "<ESC><C-w>k")

map("n", "<A-Left>", "<C-w>h")
map("i", "<A-Left>", "<ESC><C-w>h")
map("t", "<A-Left>", "<C-\\><C-n><C-w>h")

map("n", "<A-Right>", "<C-w>l")
map("i", "<A-Right>", "<ESC><C-w>l")
map("t", "<A-Right>", "<C-\\><C-n><C-w>l")

map("t", "<C-S-V>", '<C-\\><C-n>"+p<CR>i', { noremap = true })
map("i", "<C-V>", "<C-R>+", { noremap = true })

map({ "n", "i", "t" }, "<C-p>", function()
  require("telescope.builtin").find_files()
end)

map({ "n", "i", "t" }, "<C-S-f>", function()
  require("telescope.builtin").live_grep()
end)

map({ "n", "i", "t" }, "<A-c>", function()
  require("CopilotChat").toggle()
end)

-- Terminal mappings
for i = 1, 9, 1 do
  vim.keymap.set({ "n", "i" }, string.format("<A-%s>", i), function()
    pcall(vim.api.nvim_set_current_buf, vim.t.bufs[i])
  end)
end

local term = require "helpers.terminal"

for i = 1, 9, 1 do
  map({ "t" }, string.format("<A-%s>", i), function()
    term.toggle(i)
  end)
end

map({ "i", "n" }, "<C-\\>", function()
  term.toggle(1)
end)

-- LSP mappings
map({ "n", "i" }, "<C-.>", function()
  vim.lsp.buf.code_action()
end)
