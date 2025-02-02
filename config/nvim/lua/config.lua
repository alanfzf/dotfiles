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

local Util = require("lazy.core.util")

-- relevant: https://github.com/folke/lazy.nvim/discussions/1421
function Util.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  if string.find(msg, "installed") then
    return
  end
  Util.notify(msg, opts)
end

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
