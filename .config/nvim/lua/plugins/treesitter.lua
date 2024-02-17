return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      config = function()
        require('nvim-ts-autotag').setup({
          filetypes = { "html", "xml", "typescriptreact", "javascriptreact", "jsx", "tsx", "htmldjango", "blade", "php" }
        })
      end
    }
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    local install_opts = require("nvim-treesitter.install")
    install_opts.prefer_git = false;
    -- basic treesitter setup
    treesitter.setup({
      auto_install = true,
      ensure_installed = "all",
      ignore_install = { "latex" },
      highlight = {
        enable = true,
        additional_vim_regex_higlighting = false,
      },
      indent = {
        enable  = true,
        disable = { "htmldjango" }
      },
      autopairs = { enable = true },
      autotag = { enable = true },
    })
  end
}
