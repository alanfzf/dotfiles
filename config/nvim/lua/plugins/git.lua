return {
  {
    "akinsho/git-conflict.nvim",
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in: " .. vim.fn.expand("%:t") .. " ")

          vim.schedule(function()
            vim.cmd("GitConflictListQf")
            vim.cmd("cclose")
          end)
        end,
      })

      vim.keymap.set("n", "gco", "<cmd>cdo GitConflictChooseOurs<CR>")
    end,
  },
  {
    "daliusd/ghlite.nvim",
    config = function()
      require("ghlite").setup({
        keymaps = {
          comment = {
            send_comment = "<F2>",
          },
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
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
