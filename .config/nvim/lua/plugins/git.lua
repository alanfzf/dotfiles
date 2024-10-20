return {
  {
    "https://github.com/daliusd/ghlite.nvim",
    config = function()
      require("ghlite").setup({
        debug = true,
        view_split = "vsplit", -- set to empty string '' to open in active buffer
        diff_split = "vsplit", -- set to empty string '' to open in active buffer
        comment_split = "vsplit", -- set to empty string '' to open in active buffer
        open_command = "open", -- open command to use, e.g. on Linux you might want to use xdg-open
      })
    end,
  },
  { "akinsho/git-conflict.nvim", config = true },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = function(status)
        local vadd, vchanged, vremoved = status.added, status.changed, status.removed
        local table = { added = 0, modified = 0, removed = 0 }
        if vadd and vadd > 0 then
          table["added"] = vadd
        end
        if vchanged and vchanged > 0 then
          table["modified"] = vchanged
        end
        if vremoved and vremoved > 0 then
          table["removed"] = vremoved
        end
        return table
      end,
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
}
