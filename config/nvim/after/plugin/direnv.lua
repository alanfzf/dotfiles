require("direnv").setup({
  autoload_direnv = true,
  -- Keyboard mappings
  keybindings = {
    allow = "<Leader>da",
    deny = "<Leader>dd",
    reload = "<Leader>dr",
    edit = "<Leader>de",
  },
})
