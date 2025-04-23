vim.loader.enable()

local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    mini_path,
  })
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- PACKAGES
---@diagnostic disable-next-line: undefined-global
local add = MiniDeps.add

local plugins = {
  -- completion
  { source = "windwp/nvim-autopairs" },
  {
    source = "saghen/blink.cmp",
    checkout = "v1.1.1",
    depends = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- tools
  { source = "stevearc/conform.nvim" },
  { source = "mfussenegger/nvim-dap" },

  -- treesitter
  {
    source = "nvim-treesitter/nvim-treesitter",
    depends = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  -- file navigation
  { source = "stevearc/oil.nvim" },
  {
    source = "ibhagwan/fzf-lua",
    depends = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- misc
  { source = "junegunn/vim-easy-align" },
  { source = "mistweaverco/kulala.nvim" },
  { source = "otavioschwanck/arrow.nvim" },
  { source = "glacambre/firenvim" },

  -- git related
  { source = "lewis6991/gitsigns.nvim" },
  { source = "akinsho/git-conflict.nvim" },

  -- colors
  { source = "maxmx03/solarized.nvim" },
  { source = "RRethy/base16-nvim" },
  { source = "atelierbram/Base2Tone-nvim" },
  { source = "comfysage/cuddlefish.nvim" },
}

-- Register all plugins
for _, plugin in ipairs(plugins) do
  add(plugin)
end
