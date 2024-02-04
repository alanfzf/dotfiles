return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      event = "VeryLazy",
      config = function ()
        require('nvim-ts-autotag').setup({
          filetypes = { "html", "xml", "typescriptreact", "javascriptreact", "jsx", "tsx", "htmldjango", "blade", "php"}
        })
      end
    }
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    -- basic treesitter setup
    treesitter.setup({
      ensure_installed = {
        -- essential 
        "lua", "luadoc", "luap", "vim", "vimdoc", "diff", "regex", "comment",
        -- use a lot
        "html", "htmldjango", "markdown", "markdown_inline",
        "javascript", "jsdoc", "json", "python", "tsx", "typescript",
        -- i use vimtex so idk about these ones
        "bibtex",
        -- git related
        "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
        -- occasionally use
        "bash", "css", "dockerfile", "toml", "yaml",
      },
      auto_install = true,
      ignore_install = { "latex" },
      highlight = {
        enable = true,
        additional_vim_regex_higlighting = false,
      },
      indent = {
        enable = true,
        disable  = { "htmldjango" }
      },
      autopairs = { enable = true },
      autotag = { enable = true },
    })
  end
}
