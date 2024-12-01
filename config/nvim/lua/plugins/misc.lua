return {
  { "RRethy/nvim-align" },
  {
    "mistweaverco/kulala.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = "above_request",
      default_view = "headers_body",
      environment_scope = "g",
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";",
      buffer_leader_key = "m",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
        },
        filetypes = {
          ["*"] = true,
        },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        virtual_symbol = "■",
        enable_named_colors = false,
        enable_tailwind = false,
      })
    end,
  },
}
