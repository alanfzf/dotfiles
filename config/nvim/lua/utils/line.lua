-- STOLEN FROM: https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/statusline/default.lua
local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

local M = {}

---@return string
M.git = function()
  local id = stbufnr()

  if not vim.b[id].gitsigns_head or vim.b[id].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[id].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and (" +" .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and (" ~" .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and (" -" .. git_status.removed) or ""

  local branch_name = " " .. git_status.head

  return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

M.file_icon = function()
  local icon = " 󰈚 "
  local path = vim.api.nvim_buf_get_name(stbufnr())
  local name = (path == "" and "Empty ") or path:match("([^/\\]+)[/\\]*$")

  if name ~= "Empty " then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and " " .. ft_icon) or icon
    end
  end

  return "%#St_file_info#" .. icon .. " "
end

return M
