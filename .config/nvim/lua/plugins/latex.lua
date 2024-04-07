return {
  "lervag/vimtex",
  enabled = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_mode = 0
  end,
}
