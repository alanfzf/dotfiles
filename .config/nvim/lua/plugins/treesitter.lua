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
      ensure_install = { "core", "stable" },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        local parsers = require("nvim-treesitter.parsers")

        parsers.bruno = {
          tier = 0,
          filetype = "bruno",
          install_info = {
            url = "https://github.com/Scalamando/tree-sitter-bruno",
            files = { "src/parser.c" },
            branch = "main",
          },
        }

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
