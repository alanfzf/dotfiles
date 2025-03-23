local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- PACKAGES
---@diagnostic disable-next-line: undefined-global
local add = MiniDeps.add

-- completion
add({ source = "windwp/nvim-autopairs" })
add({ source = "saghen/blink.cmp", depends = {
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
} })

-- tools
add({ source = "stevearc/conform.nvim" })
add({ source = "mfussenegger/nvim-dap" })

-- treesitter
add({
  source = "nvim-treesitter/nvim-treesitter",
  depends = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
})

-- file navigation
add({ source = "stevearc/oil.nvim" })
add({
  source = "ibhagwan/fzf-lua",
  depends = {
    "nvim-tree/nvim-web-devicons",
  },
})

-- misc
add({ source = "junegunn/vim-easy-align" })
add({ source = "mistweaverco/kulala.nvim" })
add({ source = "otavioschwanck/arrow.nvim" })
add({ source = "brianhuster/live-preview.nvim" })

-- ai
add({ source = "zbirenbaum/copilot.lua" })

-- git related
add({ source = "lewis6991/gitsigns.nvim" })
add({ source = "akinsho/git-conflict.nvim" })
add({ source = "neovim/nvim-lspconfig" })

-- colors
add({ source = "maxmx03/solarized.nvim" })
add({ source = "nyoom-engineering/oxocarbon.nvim" })
add({ source = "Skardyy/makurai-nvim" })
add({ source = "Shatur/neovim-ayu" })
