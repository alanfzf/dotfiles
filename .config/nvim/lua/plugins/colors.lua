return {
  -- GOOD
  "https://github.com/Shatur/neovim-ayu",
  "https://github.com/joshdick/onedark.vim",
  {
    "https://github.com/craftzdog/solarized-osaka.nvim",
    config = function ()
      require("solarized-osaka").setup({ transparent = false, })
    end
  }
  -- "https://github.com/shaunsingh/nord.nvim",
  -- "https://github.com/gbprod/nord.nvim"
}
