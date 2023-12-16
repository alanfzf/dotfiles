return {
  "lervag/vimtex",
  init = function ()
    vim.g.maplocalleader = " "
    -- disable highlights
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_syntax_conceal_disable = 1
    -- other stuff
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'build',
      aux_dir = 'build',
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end
}
