return {
  -- GOOD
  "https://github.com/Shatur/neovim-ayu",
  "https://github.com/lifepillar/vim-solarized8",
  {
    "https://github.com/svrana/neosolarized.nvim",
    config = function ()
      require('neosolarized').setup({
        background_set = true,
      })
    end,
    dependencies = {
      "https://github.com/tjdevries/colorbuddy.nvim"
    }
  }
}
