local actions = require "helpers.actions"
local mode = actions.mode

return {
  { "<C-Right>", actions.move_next_word },
  { "<C-Left>", actions.move_previous_word },
  { "<A-Down>", actions.switch_to_bottom },
  { "<A-Up>", actions.switch_to_top },
  { "<A-Left>", actions.switch_to_left },
  { "<A-Right>", actions.switch_to_right },
  { "<C-S-V>", actions.paste_from_clipboard },
  { "<C-V>", actions.paste_from_clipboard },
  { "<C-p>", actions.find_files },
  { "<C-S-f>", actions.find_in_files },
  { "<A-c>", actions.toggle_copilot_chat },
  { "<C-\\>", actions.toggle_terminal },
  { "<C-.>", actions.show_code_actions },

  { "<A-1>", actions.switch_to_open_file(1), except = mode.terminal, desc = "Switch to open file 1" },
  { "<A-2>", actions.switch_to_open_file(2), except = mode.terminal, desc = "Switch to open file 2" },
  { "<A-3>", actions.switch_to_open_file(3), except = mode.terminal, desc = "Switch to open file 3" },
  { "<A-4>", actions.switch_to_open_file(4), except = mode.terminal, desc = "Switch to open file 4" },
  { "<A-5>", actions.switch_to_open_file(5), except = mode.terminal, desc = "Switch to open file 5" },
  { "<A-6>", actions.switch_to_open_file(6), except = mode.terminal, desc = "Switch to open file 6" },
  { "<A-7>", actions.switch_to_open_file(7), except = mode.terminal, desc = "Switch to open file 7" },
  { "<A-8>", actions.switch_to_open_file(8), except = mode.terminal, desc = "Switch to open file 8" },
  { "<A-9>", actions.switch_to_open_file(9), except = mode.terminal, desc = "Switch to open file 9" },
  { "<A-10>", actions.switch_to_open_file(10), except = mode.terminal, desc = "Switch to open file 10" },

  { "<C-t>", actions.run_associated_tests },
  { "<C-T>", actions.toggle_test_explorer },
  { "<C-R>", actions.run_all_tests },

  { "<CR>", actions.open_file, where = actions.explorer },
  { "<2-LeftMouse>", actions.open_file, where = actions.explorer },
  { "a", actions.create_file, where = actions.explorer },
  { "d", actions.remove_file, where = actions.explorer },
  { "r", actions.rename_file, where = actions.explorer },
  { "r", actions.rename_file, where = actions.explorer },

  { "<A-1>", actions.open_terminal(1), where = actions.terminal },
  { "<A-2>", actions.open_terminal(2), where = actions.terminal },
  { "<A-3>", actions.open_terminal(3), where = actions.terminal },
  { "<A-4>", actions.open_terminal(4), where = actions.terminal },
  { "<A-5>", actions.open_terminal(5), where = actions.terminal },
  { "<A-6>", actions.open_terminal(6), where = actions.terminal },
  { "<A-7>", actions.open_terminal(7), where = actions.terminal },
  { "<A-8>", actions.open_terminal(8), where = actions.terminal },
  { "<A-9>", actions.open_terminal(9), where = actions.terminal },
  { "<A-10>", actions.open_terminal(10), where = actions.terminal },
}

-- map({ "n", "v" }, "<leader>tt", function()
--   require("neotest").run.run()
-- end, { desc = "Run nearest test" })
--
-- map({ "n", "v" }, "<leader>tf", function()
--   require("neotest").run.run(vim.fn.expand "%")
-- end, { desc = "Run test file" })
--
-- map({ "n", "v" }, "<leader>ts", function()
--   require("neotest").run.run { suite = true }
-- end, { desc = "Run all tests" })
--
-- map({ "n", "v" }, "<leader>to", function()
--   require("neotest").summary.open()
-- end, { desc = "Show Summary" })
--
-- map({ "n", "v" }, "<leader>to", function()
--   require("neotest").summary.close()
-- end, { desc = "Hide Summary" })
