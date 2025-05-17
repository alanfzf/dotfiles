return {
  {
    "junegunn/vim-easy-align",
  },
  {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    init = function()
      vim.g.firenvim_config = {
        globalSettings = {},
        localSettings = {
          [".*"] = {
            takeover = "never",
          },
        },
      }
    end,
  },
  {
    "mistweaverco/kulala.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = "above_request",
      default_view = "headers_body",
      additional_curl_options = { "-L" },
      environment_scope = "g",
      kulala_keymaps = false,
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ";",
      buffer_leader_key = "m",
      custom_actions = {
        open = function(target_file_name)
          vim.cmd("tabnew " .. target_file_name)
        end,
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = function()
      return vim.fn.executable("node") == 1
    end,
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
          keymap = {
            accept = "<M-o>",
          },
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
