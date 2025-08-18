vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  underline = false,
  severity_sort = true,
})

local configs = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(configs))

vim.lsp.config("*", {
  capabilities = {
    semanticTokensProvider = false,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    local keymap = function(map, action, description, mode)
      mode = mode or "n"
      vim.keymap.set(mode, map, action, {
        buffer = bufnr,
        desc = description,
        noremap = true,
        silent = true,
      })
    end

    -- disable lsp semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

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
    keymap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")
    -- diagnostics
    keymap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Loc list")
    keymap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics")
  end,
})
