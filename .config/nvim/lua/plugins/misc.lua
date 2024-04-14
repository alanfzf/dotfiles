return {
  {
    "https://github.com/chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = true,
        cyclic = true,
        force_write_shada = true,
        refresh_interval = 250,
      })
    end,
  },
  "https://github.com/junegunn/vim-easy-align",
  {
    "https://github.com/NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = false,
          mode = "background",
          tailwind = true,
          virtualtext = "■",
          always_update = false,
        },
      })
    end,
  },
  {
    "https://github.com/razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  },
  {
    "https://github.com/LunarVim/bigfile.nvim",
    config = function()
      require("bigfile").setup({})
    end,
  },
}
