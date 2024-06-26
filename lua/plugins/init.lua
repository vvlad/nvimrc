return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
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
    opts = require "configs.treesitter",
  },

  {
    "folke/edgy.nvim",
    lazy = false,
    init = function()
      vim.opt.splitkeep = "topline"
      vim.opt.cmdheight = 0
    end,
    config = function()
      local opts = require "configs.edgy"
      require("edgy").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require "configs.nvimtree"
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
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      local helpers = require "helpers"
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(helpers.table.merge(opts, {}))

      -- load extensions
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
    config = function()
      require("copilot_cmp").setup {
        event = { "InsertEnter", "LspAttach" },
        fix_pairs = true,
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
    },
    config = function()
      local opts = require "configs.cmp"
      ---@diagnostic disable-next-line: different-requires
      require("cmp").setup(opts)
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
      "nvim-neotest/neotest-go",
      "zidhuss/neotest-minitest",
      "nvim-neotest/neotest-plenary",
    },
    lazy = true,
    config = function()
      require "configs.neotest"
    end,
  },
}
