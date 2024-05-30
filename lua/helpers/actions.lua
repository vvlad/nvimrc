local M = {}
local tabufline = require "nvchad.tabufline.utils"
local mode = {
  normal = "n",
  visual = "v",
  insert = "i",
  terminal = "t",
}

M.mode = mode

M.all_modes = { mode.normal, mode.visual, mode.insert, mode.terminal }

M.except_modes = function(except)
  if not except then
    return M.all_modes
  end
  if type(except) == "string" then
    except = { except }
  end
  local modes = {}

  for _, entry in pairs(M.all_modes) do
    if not vim.tbl_contains(except, entry) then
      table.insert(modes, entry)
    end
  end

  return modes
end

M.explorer = function(mappings)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "NvimTree",
    callback = function(opts)
      local map = require("helpers.mappings").map
      map(mappings, { buffer = opts.buf })
    end,
  })
end

M.terminal = function(mappings)
  vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function(opts)
      local map = require("helpers.mappings").map
      map(mappings, { buffer = opts.buf })
    end,
  })
end

M.btn = function(str, hl, func, arg)
  str = hl and M.txt(str, hl) or str
  arg = arg or ""
  return "%" .. arg .. "@" .. func .. "@" .. str .. "%X"
end

-- tabufline.btn = M.btn

M.move_next_word = function()
  vim.cmd [[normal! w]]
end

M.move_previous_word = function()
  vim.cmd [[normal! b]]
end

M.open_file = function()
  local api = require "nvim-tree.api"
  api.node.open.edit()
end

M.rename_file = function()
  local api = require "nvim-tree.api"
  api.fs.rename()
end

M.remove_file = function()
  local api = require "nvim-tree.api"
  api.fs.remove()

  if #vim.t.bufs == 0 then
    require("edgy.editor").goto_main()
    vim.cmd.enew()
  end
end

M.create_file = function()
  local api = require "nvim-tree.api"
  api.fs.create()
  M.open_file()
end

M.switch_to_bottom = function()
  vim.cmd [[wincmd j]]
end

M.switch_to_top = function()
  vim.cmd [[wincmd k]]
end

M.switch_to_left = function()
  vim.cmd [[wincmd h]]
end

M.switch_to_right = function()
  vim.cmd [[wincmd l]]
end

M.paste_from_clipboard = function()
  local current_buffer = vim.api.nvim_get_current_buf()
  local action_state = require "telescope.actions.state"

  if vim.bo.filetype == "TelescopePrompt" then
    local current_picker = action_state.get_current_picker(current_buffer)
    local text = vim.fn.getreg("+"):gsub("\n", "\\n")
    current_picker:set_prompt(text, false)
    return
  end

  if vim.bo.buftype == "terminal" then
    local clipboard_contents = vim.fn.getreg "+"
    local chan_id = vim.api.nvim_buf_get_var(current_buffer, "terminal_job_id")
    vim.fn.chansend(chan_id, clipboard_contents)
    return
  end

  vim.cmd [[normal! "+p]]
end

M.find_files = function()
  require("telescope.builtin").find_files()
end

M.find_in_files = function()
  require("telescope.builtin").live_grep()
end

M.toggle_copilot_chat = function()
  require("CopilotChat").toggle()
end

M.toggle_terminal = function(id)
  if not id then
    id = 1
  end
  require("helpers.terminal").toggle(id)
end

M.open_terminal = function(id)
  return function()
    M.toggle_terminal(id)
  end
end

M.switch_to_open_file = function(id)
  return function()
    require("edgy.editor").goto_main()
    pcall(vim.api.nvim_set_current_buf, vim.t.bufs[id])
  end
end

M.show_code_actions = function()
  vim.lsp.buf.code_action()
end

M.run_associated_tests = function()
  require("neotest").run.run(vim.fn.expand "%")
end

M.run_current_test = function()
  -- require("edgy.test").run_current_test()
end

M.run_all_tests = function()
  require("neotest").run.run { suite = true }
end

M.toggle_test_explorer = function()
  require("neotest").summary.toggle()
end

return M
