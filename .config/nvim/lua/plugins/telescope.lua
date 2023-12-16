return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  cmd = { "Telescope" },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  config = function()
    local actions = require('telescope.actions')
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        preview = {
          filesize_limit = 1,
        },
        -- mappings
        mappings = {
          n = {
            ["q"] = actions.close,
            ["<C-o>"] = function(p_bufnr)
              require("telescope.actions").send_selected_to_qflist(p_bufnr)
              vim.cmd.cfdo("vsplit")
            end,
          }
        },
        -- layout
        layout_config = {
          horizontal = { prompt_position = "top" }
        },
        -- other
        initial_mode = "normal",
        sorting_strategy = "ascending",
        prompt_prefix = " ",
        path_display = { "smart" },
        file_ignore_patterns = {
          "node_modules",
          ".git\\"
        }
      },
      pickers = {
        colorscheme = { enable_preview = true },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          grouped = true,
          auto_depth = true,
          respect_gitignore = false,
          use_fd = true,
          mappings = {
            ["i"] = {
              ["<bs>"] = false,
            },
          }
        },
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
    })

    telescope.load_extension('fzf')
    telescope.load_extension("file_browser")
  end,
}
