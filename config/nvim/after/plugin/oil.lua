local ok, oil = pcall(require, "oil")

if not ok then
  return
end

oil.setup({
  default_file_explorer = true,
  columns = {
    "icon",
  },
  lsp_rename_autossave = true,
  constrain_cursor = "name",
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-b>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
})

-- temporary fix hack?
vim.api.nvim_create_autocmd("User", {
  desc = "Close buffers when files are deleted in Oil",
  pattern = "OilActionsPost",
  callback = function(args)
    if args.data.err then
      return
    end
    for _, action in ipairs(args.data.actions) do
      if action.type == "delete" then
        local _, path = require("oil.util").parse_url(action.url)
        local bufnr = vim.fn.bufnr(path)
        if bufnr ~= -1 then
          vim.cmd.bwipeout({ bufnr, bang = true })
        end
      end
    end
  end,
})
