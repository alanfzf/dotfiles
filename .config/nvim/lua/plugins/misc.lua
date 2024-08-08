return {
  { "RRethy/nvim-align" },
  { "cbochs/grapple.nvim" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        virtual_symbol = "■",
        enable_named_colors = false,
        enable_tailwind = false,
      })
    end,
  },
}
