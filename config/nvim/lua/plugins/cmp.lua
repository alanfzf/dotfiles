return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
  version = "v0.*",
  opts = {
    keymap = {
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
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
        selection = "manual",
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
  },
}
