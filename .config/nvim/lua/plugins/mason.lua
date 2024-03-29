return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    })

    require("mason-tool-installer").setup({
      ensure_installed = require("utils.lsp-settings").install_list(),
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
    })
  end,
}
