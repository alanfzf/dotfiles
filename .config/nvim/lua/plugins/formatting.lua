return {
  "stevearc/conform.nvim",

  config = function ()
    require('conform').setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" }
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      }
    })
  end
}
