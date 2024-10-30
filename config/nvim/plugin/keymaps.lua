local keymap = vim.keymap.set
local opts = { silent = true }
local helper = require("utils.helper")

--[[ * ALL MODES * ]]
keymap("", "<S-h>", "^", { remap = true })
keymap("", "<S-l>", "$", { remap = true })
keymap("", "q", "<Nop>", { remap = true })

--[[ * COMMAND MODE *  ]]
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-b>", "<Left>", { noremap = true })
keymap("c", "<C-d>", "<Del>", { noremap = true })
keymap("c", "<C-e>", "<End>", { noremap = true })
keymap("c", "<C-f>", "<Right>", { noremap = true })
keymap("c", "<C-n>", "<Down>", { noremap = true })
keymap("c", "<C-p>", "<Up>", { noremap = true })
keymap("c", "<M-b>", "<S-Left>", { noremap = true })
keymap("c", "<M-f>", "<S-Right>", { noremap = true })
keymap("c", "<C-k>", [[<C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>]], { noremap = true })

--[[ * NORMAL MODE *  ]]
keymap("n", "cc", '"_cc')
-- fix j,k on virtual lines
keymap("n", "j", "gj")
keymap("n", "k", "gk")
-- better ctrl u and d movements
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- Go to specific directories
keymap("n", "<leader>c", "<cmd>e ~/.dotfiles/config/nvim/init.lua<CR>")
keymap("n", "<leader>n", "<cmd>e ~/Dropbox/Notes/<CR>")
-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>")
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Right>", ":vertical resize -2<CR>")
keymap("n", "<C-Left>", ":vertical resize +2<CR>")
-- Navigate tabs
keymap("n", "<leader>tn", ":tabnew %<CR>")
keymap("n", "<C-f>", "q:i")

--[[ * VISUAL MODE * ]]
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')

--[[ * VISUAL BLOCK *  ]]
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--[[ * OTHER PLUGINS *  ]]
-- FZF LUA
keymap("n", "<leader>ff", function()
  require("fzf-lua").files({ cwd = helper.get_root_dir() })
end, opts)
keymap("n", "<leader>fg", function()
  require("fzf-lua").live_grep({ cwd = helper.get_root_dir() })
end, opts)
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", opts)
keymap("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", opts)
keymap("n", "<leader>fs", "<cmd>FzfLua git_status<CR>", opts)
keymap("n", "<leader>fh", "<cmd>FzfLua git_bcommits<CR>", opts)
-- OIL NVIM
keymap("n", "<leader>e", "<cmd>Oil<CR>", opts)
-- LSP
keymap("n", "<leader>li", "<cmd>LspInfo<CR>")
-- GIT SIGNGS
keymap("n", "<leader>gh", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gH", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
-- DAP
keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>do", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts)
-- GRAPPLE
keymap("n", "<leader>gt", "<cmd>Grapple tag<CR>", opts)
keymap("n", "<leader>gu", "<cmd>Grapple untag<CR>", opts)
keymap("n", "<leader>gm", "<cmd>Grapple toggle_tags<CR>", opts)
