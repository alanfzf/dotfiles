local blink = require("blink-cmp")

local snip = require("luasnip")
local loader = require("luasnip.loaders.from_vscode")

-- handle luasnip
loader.lazy_load()
loader.lazy_load({ paths = "./snippets/" })

snip.filetype_extend("php", { "phpdoc" })
snip.filetype_extend("javascript", { "jsdoc" })
snip.filetype_extend("helm", { "yaml" })

-- handle blink setup
blink.setup({
  snippets = {
    preset = "luasnip",
  },
  keymap = {
    ["<CR>"] = { "accept", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-l>"] = {
      "snippet_forward",
      "fallback",
    },
    ["<C-h>"] = {
      "snippet_backward",
      "fallback",
    },
  },
  -- fuzzy
  fuzzy = {
    implementation = "prefer_rust",
    use_frecency = true,
    use_proximity = true,
    sorts = { "exact", "score", "sort_text" },
  },

  -- ** start sources **
  cmdline = {
    enabled = false,
  },
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
      max_items = 10,
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
  },
})

