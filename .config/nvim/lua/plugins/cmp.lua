return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "v0.*",
  -- build = "cargo build --release",

  opts = {
    nerd_font_variant = "normal",
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    keymap = {
      accept = "<CR>",
    },
    -- ** experimental **
    accept = { auto_brackets = { enabled = true } },
    -- ** start sources **
    sources = {
      providers = {
        {
          { "blink.cmp.sources.lsp" },
          { "blink.cmp.sources.path" },
          {
            "blink.cmp.sources.snippets",
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
          { "blink.cmp.sources.buffer", score_offset = -4 },
        },
      },
    },
    -- ** end sources **
    widnows = {
      autocomplete = {
        preselect = false,
      },
    },
  },
}
