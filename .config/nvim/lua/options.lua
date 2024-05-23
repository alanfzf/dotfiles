-- *Global configs*
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
--general
-- vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.fileencoding = "utf-8"
vim.opt.laststatus = 3
vim.opt.mouse = nil
-- backup related
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
-- search related
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- tab related
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- visual
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.showtabline = 1
vim.opt.cmdheight = 2 -- this can be 0
vim.opt.pumheight = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[set nofoldenable]])
-- misc
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.linebreak = true
vim.o.fillchars = [[foldsep: ,fold: ,foldopen:,foldclose:]]
