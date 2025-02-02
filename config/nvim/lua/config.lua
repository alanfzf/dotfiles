local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
-- fucking annoying more message go fuck yourself
vim.opt.more = false

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<space>")

require("lazy").setup("plugins", {
  ui = {
    wrap = "true",
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
  readme = {
    enabled = false,
  },
  install = {
    missing = false,
    colorscheme = { "default" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
        "tohtml",
        "tutor",
      },
    },
  },
})
