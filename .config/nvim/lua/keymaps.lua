local keymap = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO: REFACTOR THIS FUNCTION OUT OF HERE.
local function get_root_dir()
  local lsp_loc = vim.lsp.buf.list_workspace_folders()[1]

  if lsp_loc then
    return lsp_loc
  end

  local root = vim.fs.root(0, ".git")

  return root
end

--[[ * ALL MODES * ]]
keymap("", "<leader>d", '"_dd', { remap = true })
keymap("", "<S-h>", "^", { remap = true })
keymap("", "<S-l>", "$", { remap = true })
keymap("", "q", "<Nop>", { remap = true })

--[[ * COMMAND MODE *  ]]
keymap("c", "<C-A>", "<Home>", { noremap = true })
keymap("c", "<C-B>", "<Left>", { noremap = true })
keymap("c", "<C-D>", "<Del>", { noremap = true })
keymap("c", "<C-E>", "<End>", { noremap = true })
keymap("c", "<C-F>", "<Right>", { noremap = true })
keymap("c", "<C-N>", "<Down>", { noremap = true })
keymap("c", "<C-P>", "<Up>", { noremap = true })
keymap("c", "<M-b>", "<S-Left>", { noremap = true })
keymap("c", "<M-f>", "<S-Right>", { noremap = true })
keymap("c", "<C-K>", [[<C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>]], { noremap = true })

--[[ * NORMAL MODE *  ]]
keymap("n", "cc", '"_cc')
-- yank without next line
keymap("n", "<S-y>", "y$")
-- fix j,k on virtual lines
keymap("n", "j", "gj")
keymap("n", "k", "gk")
-- better ctrl u and d movements
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- Go to specific directories
keymap("n", "<leader>c", "<cmd>e $MYVIMRC<CR>")
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
-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>")
keymap("n", "<A-h>", ":bprevious<CR>")

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
  require("fzf-lua").files({ cwd = get_root_dir() })
end, opts)
keymap("n", "<leader>fg", function()
  require("fzf-lua").live_grep({ cwd = get_root_dir() })
end, opts)
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", opts)
keymap("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", opts)
keymap("n", "<leader>fs", "<cmd>FzfLua git_status<CR>", opts)
keymap("n", "<leader>fm", "<cmd>FzfLua marks<CR>", opts)
-- OIL NVIM
keymap("n", "<leader>e", "<cmd>Oil<CR>", opts)
-- LSP
keymap("n", "<leader>li", "<cmd>LspInfo<CR>")
-- LAZYGIT
keymap("n", "<leader>lg", ":tabnew term://%:p:h//lazygit<CR>A", opts)
-- GIT SIGNGS
keymap("n", "<leader>gh", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gH", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
