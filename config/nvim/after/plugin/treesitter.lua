local ts = require("nvim-treesitter.configs")
local install_opts = require("nvim-treesitter.install")
install_opts.prefer_git = false

-- basic treesitter setup
ts.setup({
  auto_install = true,
  ensure_installed = "all",
  sync_install = false,
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  highlight = {
    enable = true,
    disable = { "commonlisp" },
    additional_vim_regex_highlighting = false,
  },
})

require("nvim-ts-autotag").setup({})
