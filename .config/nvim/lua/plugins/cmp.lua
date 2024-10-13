return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets" },
  -- version = "v0.*",
  build = "cargo build --release",

  opts = {
    nerd_font_variant = "normal",
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    keymap = {
      accept = "<CR>",
      select_prev = { "<C-k>" },
      select_next = { "<C-j>" },
    },
    -- ** experimental **
    accept = { auto_brackets = { enabled = true } },
    -- ** start sources **
    sources = {
      providers = {
        { "blink.cmp.sources.lsp", name = "lsp" },
        {
          "blink.cmp.sources.snippets",
          name = "snippets",
          score_offset = -3,
          opts = {
            extended_filetypes = {
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
              extended_filetypes = {
                javascript = { "jsdoc" },
                php = { "phpdoc" },
                blade = { "html" },
              },
            },
          },
        },
        { "blink.cmp.sources.buffer", name = "buffer" },
        { "blink.cmp.sources.path", name = "path" },
      },
    },
    -- ** end sources **
    widnows = {
      autocomplete = {
        selection = "auto_insert",
      },
    },
  },
}
