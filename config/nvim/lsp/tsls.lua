local function ts_org_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }

  vim.lsp.buf.execute_command(params)
end

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
  },
  commands = {
    OrganizeImports = {
      ts_org_imports,
      description = "OrganizeImports",
    },
  },
}
