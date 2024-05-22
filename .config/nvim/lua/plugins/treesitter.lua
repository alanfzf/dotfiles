return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      config = function()
        require("nvim-ts-autotag").setup({
          filetypes = {
            "html",
            "xml",
            "typescriptreact",
            "javascriptreact",
            "jsx",
            "tsx",
            "htmldjango",
            "blade",
            "php",
          },
        })
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
      ignore_install = { "latex" },
      highlight = {
        enable = true,
        additional_vim_regex_higlighting = false,
      },
      indent = {
        enable = true,
        disable = { "htmldjango" },
      },
      autopairs = { enable = true },
    })
  end,
}
