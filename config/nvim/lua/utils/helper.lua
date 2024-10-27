local M = {}

M.get_root_dir = function()
  local lsp_loc = vim.lsp.buf.list_workspace_folders()[1]
  local status, oil = pcall(require, "oil")

  if status then
    local root = oil.get_current_dir()
    if root then
      return root
    end
  end

  if lsp_loc then
    return lsp_loc
  end

  local root = vim.fs.root(0, ".git")

  if root then
    return root
  end

  return nil
end

return M
