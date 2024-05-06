local M = {}

function M.setup()
  local on_attach = require("nvchad.configs.lspconfig").on_attach
  local on_init = require("nvchad.configs.lspconfig").on_init
  local capabilities = require("nvchad.configs.lspconfig").capabilities
  local config = require "configs.lspconfig"

  require("nvchad.configs.lspconfig").defaults()

  if not require("mason-registry").is_installed "cspell" then
    vim.cmd "MasonInstall cspell"
  end

  local servers = {}
  for _, server in ipairs(config.lsp) do
    if type(server) == "table" then
      table.insert(servers, server[1])
    else
      table.insert(servers, server)
    end
  end

  require("mason-lspconfig").setup {
    ensure_installed = servers,
    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach,
          on_init = on_init,
          capabilities = capabilities,
          settings = config.lsp[server_name] or {},
        }
      end,
    },
  }

  if require("mason-registry").is_installed "cspell" then
    local cspell = require "cspell"
    require("null-ls").setup {
      sources = {
        cspell.diagnostics.with { config = config.cspell },
        cspell.code_actions.with { config = config.cspell },
      },
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function(opts)
        vim.diagnostic.enable(false, { bufnr = opts.buf })
      end,
    })
  end
end

return M
