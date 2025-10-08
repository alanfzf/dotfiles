local fzf = require("fzf-lua")
local actions = fzf.actions

fzf.setup({
  file_icon_padding = " ",
  winopts = {
    -- make fzf non floating
    split = "belowright new",
    preview = {
      default = "bat",
      title = false,
      border = "noborder",
    },
  },
  grep = {
    multiline = true,
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
    rg_opts = "--column --line-number --files-with-matches",
    actions = {
      ["ctrl-n"] = {
        fn = function(_, opts)
          actions.toggle_flag(
            _,
            vim.tbl_extend("force", opts, {
              toggle_flag = "--fixed-strings",
            })
          )
        end,
        desc = "Toggle regex",
        header = "Toggle regex",
      },
    },
  },
  files = {
    cwd_header = false,
  },
  zoxide = {
    scope = "tab",
    git_root = false,
    -- actions = { enter = actions.cd },
  },
  -- git start
  -- i stole this from here: https://github.com/gennaro-tedesco/dotfiles/blob/86cf4de5870a64aa8c5fad2269248db9521a1c2d/nvim/lua/plugins/fzf.lua#L45-L56
  git = {
    winopts = {
      preview = {
        hidden = "nohidden",
      },
    },
    bcommits = {
      cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen%><(12)%cr%><|(12)%Creset %s' <file>",
      preview = "git show --stat --color --format='%C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' {1} -- <file>",
      actions = {
        ["ctrl-d"] = function(...)
          fzf.actions.git_buf_vsplit(...)
          vim.cmd("windo diffthis")
          local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
          vim.api.nvim_feedkeys(switch, "t", false)
        end,
      },
    },
    branches = {
      cmd = "git branch --all --color",
    },
  },
  -- git end
  keymap = {
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"] = "toggle-help",
      ["<F2>"] = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"] = "toggle-preview-wrap",
      ["<F4>"] = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["ctrl-n"] = "kill-line",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-f"] = "half-page-down",
      -- ["ctrl-n"] = "unix-line-discard",
      ["alt-a"] = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"] = "toggle-preview-wrap",
      ["f4"] = "toggle-preview",
      ["ctrl-d"] = "preview-page-down",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-x"] = "select-all+accept",
    },
  },

  fzf_colors = {
    true,
    ["bg"] = "-1",
  },
  fzf_opts = {
    ["--border"] = "none",
    ["--cycle"] = true,
    ["--info"] = "hidden",
    ["--no-info"] = "",
    ["--header"] = " ",
  },
})
