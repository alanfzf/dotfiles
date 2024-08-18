return {
  { "https://github.com/Shatur/neovim-ayu" },
  { "https://github.com/bluz71/vim-nightfly-colors" },
  { "https://github.com/ellisonleao/gruvbox.nvim" },
  "https://github.com/Mofiqul/dracula.nvim",
  "https://github.com/NTBBloodbath/doom-one.nvim",
  "https://github.com/ishan9299/nvim-solarized-lua",
  "https://github.com/aliqyan-21/darkvoid.nvim",
  "https://github.com/0xstepit/flow.nvim",
  "https://github.com/blazkowolf/gruber-darker.nvim",
  "https://github.com/comfysage/evergarden",
  {
    "https://github.com/svrana/neosolarized.nvim",
    dependencies = {
      "https://github.com/tjdevries/colorbuddy.nvim",
    },
    config = function()
      require("neosolarized").setup({
        comment_italics = true,
        background_set = false,
      })
    end,
  },
}
