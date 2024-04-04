return {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function get_diff()
      local dict = vim.b.gitsigns_status_dict
      return dict
    end

    local function get_progress()
      return vim.fn.line(".") .. ":" .. vim.fn.line("$")
    end

    local diff = {
      "diff",
      colored = false,
      symbols = { added = "+", modified = "~", removed = "-" },
      source = get_diff,
    }

    require("lualine").setup({
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = "",
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diff },
        lualine_c = {},
        lualine_x = { { "filename", path = 1 }, "encoding" },
        lualine_y = { "filetype", "fileformat" },
        lualine_z = { get_progress },
      },
    })
  end,
}
