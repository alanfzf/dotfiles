local ok, conform = pcall(require, "conform")

if not ok then
  return
end

conform.setup({
  formatters_by_ft = {
    svelte = { "prettier" },
    nix = { "nixfmt" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier", "jq" },
    jsonc = { "prettier", "jq" },
    scss = { "prettier" },
    css = { "prettier" },
    lua = { "stylua" },
    php = { "php_cs_fixer" },
    blade = { "blade-formatter" },
    yaml = { lsp_format = "fallback" },
    helm = { lsp_format = "fallback" },
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

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
