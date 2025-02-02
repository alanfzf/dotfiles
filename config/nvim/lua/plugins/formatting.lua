return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        nix = { "nixfmt" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        scss = { "prettier" },
        css = { "prettier" },
        lua = { "stylua" },
        php = { "php_cs_fixer" },
        blade = { "blade-formatter" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      format_after_save = {
        lsp_fallback = false,
        async = true,
        timeout_ms = 1500,
      },
      formatters = {
        prettier = {
          require_cwd = true,
        },
      },
    })
  end,
}
