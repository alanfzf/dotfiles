return {
  {
    "iamcco/markdown-preview.nvim",
    ft="markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "https://github.com/alanfzf/md-tools", 
    config = function ()
      require("md-tools").setup({})
    end
  }
}
