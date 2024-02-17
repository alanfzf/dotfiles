vim.api.nvim_create_user_command('SetCwd', function()
  vim.cmd [[cd %:p:h]]
end, { nargs = 0 })

vim.api.nvim_create_user_command('SetTransparency', function()
  -- NOTE: using the nvim api to remove the background doesn't work properly
  vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
  vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
end, { nargs = 0 })

vim.api.nvim_create_user_command('FixM', function()
  vim.cmd [[
  w
  e ++ff=dos
  set ff=unix
  ]]
end, { nargs = 0 })
