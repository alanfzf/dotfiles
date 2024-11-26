return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
  version = "v0.*",
  opts = {
    nerd_font_variant = "normal",
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    keymap = {
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
      --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    accept = {
      expand_snippet = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      auto_brackets = { enabled = true },
    },
    -- fuzzy
    fuzzy = {
      use_typo_resistance = false,
      use_frecency = false,
      use_proximity = false,
    },

    -- ** start sources **
    sources = {
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = -2,
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = -5,
          fallback_for = {},
        },
      },
    },
    -- ** end sources **
    windows = {
      autocomplete = {
        selection = "manual",
      },
    },
  },
}
