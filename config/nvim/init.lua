vim.loader.enable()
vim.pack.add({
  -- misc/dependencies
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/glacambre/firenvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/otavioschwanck/arrow.nvim",
  "https://github.com/mistweaverco/kulala.nvim",
  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
  -- treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
  -- autocompletion
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  -- code formatting
  "https://github.com/stevearc/conform.nvim",
  -- debug
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/junegunn/vim-easy-align",
  -- file navigation
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  -- ai
  "https://github.com/zbirenbaum/copilot.lua",
  -- colorschemes
  "https://github.com/alanfzf/onedark.nvim",
  "https://github.com/rktjmp/lush.nvim",
})
