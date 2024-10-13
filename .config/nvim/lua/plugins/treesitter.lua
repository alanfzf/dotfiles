return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      config = function()
        require("nvim-ts-autotag").setup({})
      end,
    },
  },
  config = function()
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
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
