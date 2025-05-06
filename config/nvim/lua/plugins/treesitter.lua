---@diagnostic disable: duplicate-set-field
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      config = true,
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup({
          enable_autocmd = false,
          custom_calculation = function(_node, language_tree)
            if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" then
              return "{{-- %s --}}"
            end
          end,
        })

        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
          return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
            or get_option(filetype, option)
        end
      end,
    },
  },
  config = function()
    local ts = require("nvim-treesitter.configs")
    local install_opts = require("nvim-treesitter.install")
    install_opts.prefer_git = false
    -- basic treesitter setup
    ts.setup({
      auto_install = true,
      ensure_installed = "all",
      ignore_install = { "scfg", "ocamllex", "teal", "mlir", "latex", "unison", "swift", "norg" },
      sync_install = false,
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      highlight = {
        enable = true,
        disable = { "commonlisp" },
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
