return {
  "ibhagwan/fzf-lua",
  branch = "windows",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({

      file_icon_padding = ' ',
      keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"]  = "toggle-help",
          ["<F2>"]  = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]  = "toggle-preview-wrap",
          ["<F4>"]  = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]  = "toggle-preview-ccw",
          ["<F6>"]  = "toggle-preview-cw",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-z"]      = "abort",
          ["ctrl-n"]      = "unix-line-discard",
          ["ctrl-f"]      = "half-page-down",
          ["ctrl-b"]      = "half-page-up",
          ["ctrl-a"]      = "beginning-of-line",
          ["ctrl-e"]      = "end-of-line",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"]          = "toggle-preview-wrap",
          ["f4"]          = "toggle-preview",
          ["ctrl-d"]  = "preview-page-down",
          ["ctrl-u"]    = "preview-page-up",
        },
      },
      fzf_opts = {
        ['--cycle'] = true,
        ['--color'] = "bg+:-1",
      },
      previewers = {
        builtin = {
          syntax          = true,         -- preview syntax highlight?
          syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
          syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
          limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
        },
      }

    })
  end
}
