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
    -- fuzzy
    fuzzy = {
      use_frecency = false,
      use_proximity = false,
    },

    -- ** start sources **
    sources = {
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true, -- whether or not to enable the provider
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = -3,
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = -2,
          fallback_for = {},
        },
      },
    },
    -- ** end sources **
    windows = {
      autocomplete = {
        selection = "manual",
        draw = "reversed",
      },
    },
  },
}
