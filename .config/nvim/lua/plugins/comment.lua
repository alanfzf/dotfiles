return {
  {
    "numToStr/Comment.nvim",
    event = {"BufRead", "BufNewFile"},
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,

    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
      init = function ()
        vim.g.skip_ts_context_commentstring_module = true
      end,
      config = function ()
        require('ts_context_commentstring').setup({
          custom_calculation = function (_node, language_tree)
            if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' then
              return '{{-- %s --}}'
            end
          end,
        })
      end
    }
  },
}
