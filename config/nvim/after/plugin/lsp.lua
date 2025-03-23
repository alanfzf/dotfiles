--- TODO: At some point we might remove lspconfig, so here are great tutorials
--- on how to use native lsp:
--- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
--- https://www.reddit.com/r/neovim/comments/up5ahi/using_the_builtin_lsp_client_without_nvimlspconfig/
--- https://www.reddit.com/r/neovim/comments/12itdmx/psa_configuring_lsp_wo_nvimlspconfig_is_simple/

local lspconfig = require("lspconfig")
local configs = require("utils.lsp-settings").lsp_configs
local helper = require("utils.lsp-helper")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

for name, conf in pairs(configs) do
  local opts = {
    on_init = helper.on_init,
    on_attach = helper.on_attach,
    capabilities = capabilities,
  }
  opts = vim.tbl_deep_extend("force", conf, opts)
  lspconfig[name].setup(opts)
end
