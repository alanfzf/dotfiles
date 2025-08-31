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

-- TODO: this is AI slop so... we gotta clean it up later
M.lua_eval_buffer = function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf) == "[LuaEval]" then
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end

  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, "[LuaEval]")
  vim.api.nvim_set_current_buf(buf)

  -- Buffer options
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("filetype", "lua", { buf = buf })
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })

  -- Helper: try to eval as expression first
  local function eval_line(line)
    local chunk, err = loadstring("return " .. line)

    if not chunk then
      chunk, err = loadstring(line)
    end

    if not chunk then
      vim.notify("Lua error: " .. err, vim.log.levels.ERROR)
      return
    end

    local ok, result = pcall(chunk)

    if not ok then
      vim.notify("Runtime error: " .. result, vim.log.levels.ERROR)
    else
      -- Pretty-print result
      if result == nil then
        vim.notify("nil", vim.log.levels.INFO)
      else
        vim.notify(vim.inspect(result), vim.log.levels.INFO)
      end
    end
  end

  -- Eval current line with <CR>
  vim.keymap.set("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    eval_line(line)
  end, { buffer = buf })

  -- Eval whole buffer with <leader>rr
  vim.keymap.set("n", "<leader>rr", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local code = table.concat(lines, "\n")
    local chunk, err = loadstring(code)
    if not chunk then
      vim.notify("Lua error: " .. err, vim.log.levels.ERROR)
      return
    end
    local ok, result = pcall(chunk)
    if not ok then
      vim.notify("Runtime error: " .. result, vim.log.levels.ERROR)
    else
      if result == nil then
        vim.notify("nil", vim.log.levels.INFO)
      else
        vim.notify(vim.inspect(result), vim.log.levels.INFO)
      end
    end
  end, { buffer = buf })
end

return M
