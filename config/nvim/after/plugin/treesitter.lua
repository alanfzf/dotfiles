-- its not required to call treesitter setup here?
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldlevel = 99
    end
  end,
})

-- autotag
require("nvim-ts-autotag").setup({})

-- ts context comment string
require("ts_context_commentstring").setup({
  enable_autocmd = false,
  custom_calculation = function(_node, language_tree)
    if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" then
      return "{{-- %s --}}"
    end
  end,
})

local get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end
