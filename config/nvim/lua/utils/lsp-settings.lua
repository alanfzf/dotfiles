local M = {}

-- most common language servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
-- php workflow:
-- intelephense
-- php-cs-fixer
-- blade-formatter
-- prettier

-- lsp servers
local lsp_servers = {
  -- PHP
  intelephense = {
    init_options = {
      globalStoragePath = vim.fn.expand("$HOME/.intelephense"),
      licenceKey = vim.fn.expand("$HOME/.intelephense/licence.txt"),
    },
  },
  -- LATEX
  texlab = {},
  -- MARKDOWN
  marksman = {},
  -- LUA
  lua_ls = {
    single_file_support = false,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" },
          disable = {
            "missing-fields",
            "incomplete-signature-doc",
          },
          unusedLocalExclude = { "_*" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config")] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  },
  -- TS & JS
  ts_ls = {
    single_file_support = false,
  },
  -- PYTHON
  pyright = {
    single_file_support = false,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
        },
      },
    },
  },
}

M.lsp_configs = function()
  return lsp_servers
end

return M
