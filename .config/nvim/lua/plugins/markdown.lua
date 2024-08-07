return {
  { "jannis-baum/vivify.vim" },
  {
    "https://github.com/alanfzf/md-tools",
    ft = "markdown",
    config = function()
      require("md-tools").setup({})
    end,
  },
}
