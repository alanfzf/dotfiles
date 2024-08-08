vim.api.nvim_create_user_command("SetTransparency", function()
  -- NOTE: using the nvim api to remove the background doesn't work properly
  vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
  vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
end, { nargs = 0 })

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

  local result = vim.system({ "gh", "browse", "-b", branch, filename .. ":" .. lnum }, { text = true }):wait()
  if result.code ~= 0 then
    print("Gbrowse error")
  end
end, {})
