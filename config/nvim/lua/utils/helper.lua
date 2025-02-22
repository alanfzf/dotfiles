local M = {}

M.get_root_dir = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = current_buf })

  -- theres at least one client
  if #clients > 0 then
    local client = clients[1]
    local workspace = client.config.workspace_folders[1]

    if workspace then
      return workspace.name
    end
  end

  -- as fallback check git root
  local root = vim.fs.root(0, ".git")

  if root then
    return root
  end

  return nil
end

return M
