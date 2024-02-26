return {
  -- GOOD
  "https://github.com/Shatur/neovim-ayu",
  "https://github.com/Mofiqul/dracula.nvim",
  -- "https://github.com/gbprod/nord.nvim"
  {
    "https://github.com/svrana/neosolarized.nvim",
    config = function ()
      require('neosolarized').setup({})
    end,
    dependencies = {
      "https://github.com/tjdevries/colorbuddy.nvim"
    }
  }
}
