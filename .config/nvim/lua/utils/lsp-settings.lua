local M = {}

-- list of available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local mason_list = {
  "omnisharp",
  "blade-formatter",
  "emmet-language-server",
  "intelephense",
  "lua-language-server",
  "marksman",
  "php-cs-fixer",
  "prettier",
  "pyright",
  "stylua",
  "texlab",
  "typescript-language-server",
}

-- lsp servers
local lsp_servers = {
  omnisharp = {
    cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    enable_import_completion = true,
    enable_roslyn_analyzers = true,
  },
  intelephense = {
    init_options = {
      -- globalStoragePath =  vim.fn.expand('$HOME/.intelephense')
      -- can't use this as licence is not triggered
    },
  },
  texlab = {},
  -- MARKDOWN
  marksman = {},
  -- EMMET
  emmet_language_server = {
    single_file_support = true,
    filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact", "blade" },
  },
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
  tsserver = {
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

M.install_list = function()
  return mason_list
end

M.lsp_configs = function()
  return lsp_servers
end

return M
