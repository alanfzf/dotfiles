local M = {}

M.set_lsp_keymaps = function(bufnr)
  -- helper function to define keymaps
  local keymap = function(map, action, description, mode)
    mode = mode or "n"
    vim.keymap.set(mode, map, action, {
      buffer = bufnr,
      desc = description,
      noremap = true,
      silent = true,
    })
  end

  -- references & definitions
  keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
  keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
  keymap("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
  keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References")
  -- documentation
  keymap("<S-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
  keymap("<M-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
  -- actions
  keymap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename definition")
  keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")
  -- diagnostics
  keymap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Loc list")
  keymap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics")

  keymap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic")
  keymap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")

  --[[
  -- TODO: add when 0.11 releases
  -- [e => vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  -- ]e => vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  --]]
end

---@diagnostic disable-next-line: unused-local
M.on_init = function(client, bufnr)
  if client.server_capabilities then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = false
  end
end

---@diagnostic disable-next-line: unused-local
M.on_attach = function(client, bufnr)
  M.set_lsp_keymaps(bufnr)
end

return M
