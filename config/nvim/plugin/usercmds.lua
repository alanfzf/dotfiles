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

vim.api.nvim_create_user_command("GSplit", function()
  local root = vim.fs.root(0, ".git")

  if not root then
    print("Not a git repository")
    return
  end

  local filename = vim.fn.expand("%:p"):gsub(root .. "/", "", 1)

  local result = vim.system({ "git", "show", "main:" .. filename }, { text = true }):wait()
  local data = result.stdout
  local lines = vim.split(data or "", "\n")

  local bid = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bid })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bid })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bid })
  vim.api.nvim_buf_set_lines(bid, 0, -1, false, lines)
  vim.api.nvim_set_option_value("filetype", vim.api.nvim_buf_get_option_value(0, "filetype"), { buf = bid })

  vim.api.nvim_buf_set_name(bid, "GSplit")
  vim.api.nvim_command("vsplit")
  vim.api.nvim_set_current_buf(bid)

  -- print(vim.inspect(result))
end, {})

vim.api.nvim_create_user_command("GBrowse", function()
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
