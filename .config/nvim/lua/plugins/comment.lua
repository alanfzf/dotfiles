return {
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
}
