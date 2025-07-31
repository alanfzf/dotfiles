-- remove annoying windows line endings
vim.api.nvim_create_user_command("FixM", function()
  vim.api.nvim_exec2("edit ++ff=dos %", {})
end, { nargs = 0 })

-- useful for kulala to preview HTML files
vim.api.nvim_create_user_command("OpenHtml", function()
  -- TODO: maybe another solution, https://stackoverflow.com/a/41312080
  local contents = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
  local join_contents = table.concat(contents, "\n")
  local temp_file_path = os.tmpname() .. ".html"
  local file = io.open(temp_file_path, "w")

  if file then
    file:write(join_contents)
    file:close()
  end

  if vim.fn.has("wsl") then
    local wslpath = vim.fn.system("wslpath -w " .. temp_file_path):gsub("\n", "")
    temp_file_path = wslpath
  end

  vim.ui.open(temp_file_path)
end, { nargs = 0 })

-- Mimic gbrowse command from fugitive
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

  vim.ui.open(url)
end, { nargs = 0 })
