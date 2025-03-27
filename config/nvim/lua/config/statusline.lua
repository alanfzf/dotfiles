local line_utils = require("utils.line")

function _G.statusline()
  return table.concat({
    " ",
    line_utils.git(),
    "%=",
    "%f",
    line_utils.file_icon(),
    "%l:%L",
    " ",
  }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
