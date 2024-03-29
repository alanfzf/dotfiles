return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    })
    require("mason-lspconfig").setup({
      ensure_installed = require("utils.lsp-settings").install_list(),
      automatic_installation = true,
    })
  end,
}
