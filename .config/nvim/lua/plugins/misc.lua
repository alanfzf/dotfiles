return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
  { "https://github.com/junegunn/vim-easy-align" },
  {
    "https://github.com/brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        virtual_symbol = "■",
        enable_named_colors = true,
        enable_tailwind = false,
      })
    end,
  },
  {
    "https://github.com/razak17/tailwind-fold.nvim",
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
