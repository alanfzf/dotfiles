return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  },
  version = "v0.*",
  opts = {
    keymap = {
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Tab>"] = {
        function(cmp)
          return cmp.select_next()
        end,
        "snippet_forward",
        "fallback",
      },

      ["<S-Tab>"] = {
        function(cmp)
          return cmp.select_prev()
        end,
        "snippet_backward",
        "fallback",
      },
    },
    snippets = {
      preset = "luasnip",
    },
    -- fuzzy
    fuzzy = {
      use_typo_resistance = false,
      use_frecency = true,
      use_proximity = true,
    },

    -- ** start sources **
    sources = {
      cmdline = {},
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          min_keyword_length = 2,
          fallbacks = {},
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
        },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
  },
}
