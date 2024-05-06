vim.ui.select = function(items, opts, on_choice)
  local Menu = require "nui.menu"
  local format_entry = opts.format_item or tostring
  local choices = {}
  local width = 0

  for index, item in pairs(items) do
    local text, _ = format_entry(item)
    text = string.format(" %s ", text)
    width = math.max(width, #text)
    table.insert(choices, Menu.item(text, { item = item, index = index }))
  end
  local menu = Menu({
    relative = "cursor",
    position = {
      row = 2,
      col = 1,
    },
    size = {
      height = math.min(#choices, 10) + 2,
    },
    border = {
      style = "none",
      padding = {
        top = 1,
        bottom = 1,
        left = 1,
        right = 1,
      },
    },
    win_options = {
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel",
    },
  }, {
    lines = choices,
    max_width = width,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      on_choice(nil, nil)
    end,
    on_submit = function(choice)
      on_choice(choice.item, choice.item)
    end,
  })

  menu:mount()
  vim.wo.cursorline = true
  vim.wo.cursorlineopt = "screenline"
end
