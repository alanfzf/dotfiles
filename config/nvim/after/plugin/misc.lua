local later = MiniDeps.later

later(function()
  require("kulala").setup({
    show_icons = "above_request",
    default_view = "headers_body",
    additional_curl_options = { "-L" },
    environment_scope = "g",
    kulala_keymaps = false,
  })

  require("arrow").setup({
    separate_save_and_remove = true,
    separate_by_branch = true,
    show_icons = true,
    leader_key = ";",
    buffer_leader_key = "m",
    custom_actions = {
      open = function(target_file_name)
        vim.cmd("tabnew " .. target_file_name)
      end,
    },
  })

  -- require("copilot").setup({
  --   panel = {
  --     enabled = true,
  --     auto_refresh = true,
  --   },
  --   suggestion = {
  --     enabled = true,
  --     auto_trigger = true,
  --     hide_during_completion = true,
  --     debounce = 75,
  --     keymap = {
  --       accept = "<M-o>",
  --     },
  --   },
  --   filetypes = {
  --     ["*"] = true,
  --   },
  -- })
end)
