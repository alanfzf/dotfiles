return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      init = function()
        -- vim.g.skip_ts_context_commentstring_module = true
      end,
      config = function()
        require("ts_context_commentstring").setup({
          custom_calculation = function(_node, _language_tree)
            if vim.bo.filetype == "blade" then
              return "{{-- %s --}}"
            end
          end,
        })
      end,
    },
  },
}
