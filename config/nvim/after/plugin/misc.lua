require("kulala").setup({
  show_icons = "above_request",
  default_view = "headers_body",
  additional_curl_options = { "-L" },
  environment_scope = "g",
  kulala_keymaps = false,
})

require("nvim-highlight-colors").setup({
  render = "background",
  virtual_symbol = "■",
  enable_named_colors = false,
  enable_tailwind = false,
})

-- ARROW setup
require("arrow").setup({
  show_icons = true,
  leader_key = ";",
  buffer_leader_key = "m",
  custom_actions = {
    open = function(target_file_name)
      vim.cmd("tabnew " .. target_file_name)
    end,
  },
})

require("orgmode").setup({})
