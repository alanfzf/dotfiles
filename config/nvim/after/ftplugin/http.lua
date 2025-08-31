vim.api.nvim_set_keymap("n", "<leader>hp", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hn", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hr", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>he",
  ":lua require('kulala').set_selected_env()<CR>",
  { noremap = true, silent = true }
)
