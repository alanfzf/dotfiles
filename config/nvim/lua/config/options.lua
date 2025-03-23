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
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vim.opt.laststatus = 3
vim.opt.mouse = ""
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
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 0
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- visual
vim.opt.jumpoptions = "stack,view"
vim.opt.splitkeep = "screen"
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
vim.opt.pumheight = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cmdheight = 2
-- misc
vim.opt.shortmess:append("cOt")
vim.opt.iskeyword:append("-")
vim.opt.linebreak = true
vim.opt.foldtext = ""
vim.opt.smoothscroll = true
vim.opt.fillchars = {
  foldsep = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  diff = "╱",
}

vim.opt.list = true
vim.opt.listchars = {
  tab = "▏ ",
  trail = "·",
  extends = "»",
  precedes = "«",
}

-- disable colorschemes
vim.opt.wildignore:append({
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
