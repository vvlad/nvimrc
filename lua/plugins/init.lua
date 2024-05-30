return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup(require "configs.conform")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
      "davidmh/cspell.nvim",
    },
    config = function()
      require("helpers.lspconfig").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      require "configs.treesitter"
    end,
  },

  {
    "folke/edgy.nvim",
    lazy = false,
    init = function()
      vim.opt.splitkeep = "topline"
      vim.opt.cmdheight = 0
    end,
    opts = function()
      return require "configs.edgy"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      local helpers = require "helpers"
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(helpers.table.merge(opts, {}))
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end

      telescope.load_extension "fzf"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    command = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        ruby = true,
        eruby = true,
        javascript = true,
      },
    },
  },

  {
    "zbirenbaum/copilot-cmp",
    opts = {
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = { "CopilotChatToggle", "CopilotChat" },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false, -- Enable debugging
      auto_insert_mode = true,
    },
  },

  {
    "MunifTanjim/nui.nvim",
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require "helpers.ui-select"
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "zidhuss/neotest-minitest",
      "nvim-neotest/neotest-plenary",
    },
    lazy = true,
    opts = function()
      return require "configs.neotest"
    end,
  },

  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
