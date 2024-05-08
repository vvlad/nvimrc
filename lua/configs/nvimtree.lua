local options = {
  sync_root_with_cwd = false,
  prefer_startup_root = true,
  filters = {
    dotfiles = true,
    git_ignored = true,
    custom = {
      "^log$",
      "^tmp$",
      "*-lock.json",
      "*.lock",
      "*.lockb",
      "^build(s)?$",
      "^dist$",
    },
    exclude = {
      ".gitignore",
      ".gitlab-ci.yml",
      ".dockerignore",
      "secrets.ejson",
    },
  },

  actions = {
    remove_file = {
      close_window = true,
    },
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
  },

  ui = {
    confirm = {
      default_yes = true,
    },
  },

  update_focused_file = {
    enable = true,
    update_root = false,
  },
  hijack_directories = {
    enable = false,
  },
  renderer = {
    highlight_git = "none",
    highlight_diagnostics = "none",
    highlight_opened_files = "none",
    highlight_bookmarks = "none",
    highlight_clipboard = "name",
    root_folder_label = false,
    indent_markers = {
      enable = true,
      inline_arrows = false,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },

    icons = {
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      },
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = false,
        modified = false,
        diagnostics = false,
        bookmarks = false,
      },
    },
  },
}

local function open_project_root(file)
  local lspconfig = require "lspconfig"
  local directory = lspconfig.util.find_git_ancestor(file)

  if not directory then
    if vim.fn.isdirectory(file) == 1 then
      directory = file
    else
      return
    end
  end

  vim.cmd.cd(directory)

  require("nvim-tree.api").tree.open {
    path = vim.g.project_directory,
    current_window = false,
    focus = false,
  }

  vim.defer_fn(function()
    vim.cmd "wincmd l"
  end, 150)
end

local helpers = require "helpers"
dofile(vim.g.base46_cache .. "nvimtree")
local defaults = require "nvchad.configs.nvimtree"
require("nvim-tree").setup(helpers.table.merge(defaults, options))

if vim.g.project_directory then
  open_project_root(vim.g.project_directory)
end
