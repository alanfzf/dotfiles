local opt = vim.opt

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
-- *Global configs*
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
--general
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
opt.laststatus = 3
opt.mouse = ""
-- backup related
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
-- search related
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
-- tab related
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
-- visual
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.relativenumber = true
opt.signcolumn = "yes"
opt.number = true
opt.numberwidth = 4
opt.cursorline = true
opt.showmode = false
opt.termguicolors = true
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = true
opt.cmdheight = 2
-- misc
opt.shortmess:append("c")
opt.iskeyword:append("-")
opt.linebreak = true
opt.foldtext = ""
opt.smoothscroll = true
opt.fillchars = {
  foldsep = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
}
-- disable colorschemes
opt.wildignore:append({
  "blue.vim",
  "darkblue.vim",
  "delek.vim",
  "desert.vim",
  "elflord.vim",
  "evening.vim",
  "industry.vim",
  "habamax.vim",
  "koehler.vim",
  "lunaperche.vim",
  "morning.vim",
  "murphy.vim",
  "pablo.vim",
  "peachpuff.vim",
  "quiet.vim",
  "ron.vim",
  "shine.vim",
  "slate.vim",
  "sorbet.vim",
  "retrobox.vim",
  "torte.vim",
  "wildcharm.vim",
  "zaibatsu.vim",
  "zellner.vim",
})
