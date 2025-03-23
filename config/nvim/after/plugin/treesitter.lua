local ts = require("nvim-treesitter.configs")
local install_opts = require("nvim-treesitter.install")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
install_opts.prefer_git = false

parser_config.blade = {
  filetype = "blade",
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
}

-- basic treesitter setup
ts.setup({
  auto_install = true,
  ensure_installed = "all",
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
