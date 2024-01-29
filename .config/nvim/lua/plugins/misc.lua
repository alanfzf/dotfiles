return {
  "https://github.com/junegunn/vim-easy-align",
  {
    "https://github.com/NvChad/nvim-colorizer.lua",
    config = function ()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          names = false,
          mode = "background",
          tailwind = true,
          virtualtext = "■",
          always_update = false
        }
      }
    end
  }
}
