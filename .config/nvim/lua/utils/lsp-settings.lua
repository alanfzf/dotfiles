local M = {}

-- list of available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
M.servers = {
  cssls = {
    filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact", "blade"}
  },
  intelephense = {
    init_options = {
          globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
      }
  },
  texlab = {},
  -- MARKDOWN 
  marksman = {},
  -- EMMET
  emmet_language_server = {
    single_file_support = true,
    filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact", "blade"}
  },
  -- POWERSHELL
  -- HTML
  html = {
    single_file_support = true,
    filetypes = { "html", "htmldjango", "blade"}
  },
  -- LUA
  lua_ls = {
    single_file_support = false,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim' },
          disable = {
            "missing-fields",
            "incomplete-signature-doc"
          },
          unusedLocalExclude = {"_*"}
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config')] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  },
  -- TS & JS
  tsserver = {
    single_file_support = false
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

M.install_list = function ()
  local sv_list = M.servers
  local install = {}
  local n = 0

  for k, _ in pairs(sv_list) do
    n = n+1
    install[n] = k
  end

  return install
end

return M
