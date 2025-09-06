local M = {}

local get_lsp_root_dir = function()
  local buf_num = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf_num })

  for _index, client in ipairs(clients) do
    local workspace = client.config.workspace_folders

    if workspace and #workspace > 0 then
      return workspace[1].name
    end
  end

  return nil
end

M.get_root_dir = function()
  -- lsp root
  local lsp_root = get_lsp_root_dir()

  if lsp_root then
    return lsp_root
  end

  -- as fallback check git root
  local root = vim.fs.root(0, ".git")

  if root then
    return root
  end

  return nil
end

return M
