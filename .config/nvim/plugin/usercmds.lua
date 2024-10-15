vim.api.nvim_create_user_command("FixM", function()
  vim.cmd([[
  w
  e ++ff=dos
  set ff=unix
  ]])
end, { nargs = 0 })

vim.api.nvim_create_user_command("ClearWhiteSpaces", function()
  vim.cmd([[ %s/\s\+$//e ]])
end, { nargs = 0 })

vim.api.nvim_create_user_command("Gbrowse", function()
  local root = vim.fs.root(0, ".git")

  if not root then
    print("Not a git repository")
    return
  end

  local branch = vim.fn.system("git -C " .. root .. " branch --show-current"):gsub("\n", "")
  local filename = vim.fn.expand("%:p:~:.")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]

  if filename == "" then
    print("No file name")
    return
  end

  local result = vim.system({ "gh", "browse", "-n", "-b", branch, filename .. ":" .. lnum }, { text = true }):wait()
  local url = result.stdout

  if result.code ~= 0 or not url then
    print("GH-CLI error")
    return
  end

  print("Opening repo: " .. url)
  vim.ui.open(url)
end, {})

vim.api.nvim_create_user_command("Scratch", function()
  if vim.g.scratch_buffer == nil then
    local bid = vim.api.nvim_create_buf(true, true)
    vim.g.scratch_buffer = bid
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = bid })
    vim.api.nvim_set_option_value("swapfile", false, { buf = bid })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = bid })
    vim.api.nvim_buf_set_name(bid, "Scratch")
  end

  local buf = vim.g.scratch_buffer
  vim.api.nvim_command("vsplit")
  vim.api.nvim_set_current_buf(buf)
end, {})
