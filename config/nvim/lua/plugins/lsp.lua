local setup_lsp_servers = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  end

  local lspconfig = require("lspconfig")
  local lsp_ui = require("lspconfig.ui.windows")
  lsp_ui.default_options.border = "rounded"

  local on_attach = function(_client, bufnr)
    lsp_keymaps(bufnr)
  end

  local on_init = function(client, _initialization_result)
    if client.server_capabilities then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.semanticTokensProvider = false -- turn off semantic tokens
    end
  end

  local configs = require("utils.lsp-settings").lsp_configs()

  for name, conf in pairs(configs) do
    local opts = {
      on_init = on_init,
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend("force", conf, opts)
    lspconfig[name].setup(opts)
  end

  -- LSP setup
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable underline, it's very annoying
    underline = false,
    virtual_text = true,
    -- Enable virtual text, override spacing to 4
    -- virtual_text = {spacing = 4},
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = true,
    update_in_insert = false,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local M = {
  "neovim/nvim-lspconfig",
  config = function()
    setup_lsp_servers()
  end,
}

return M
