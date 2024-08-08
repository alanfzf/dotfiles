return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
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
    -- basic treesitter setup
    require("nvim-treesitter").setup({
      auto_install = true,
      ensure_install = { "all" },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        local parsers = require("nvim-treesitter.parsers")
        parsers.blade = {
          tier = 0,
          filetype = "blade",
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
        }
      end,
    })
  end,
}
