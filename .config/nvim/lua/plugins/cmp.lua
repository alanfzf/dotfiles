return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- Load my snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets/" })
    -- additional configs
    luasnip.filetype_extend("javascript", { "jsdoc" })
    luasnip.filetype_extend("php", { "phpdoc", "blade" })

    local kind_icons = {
      Text = "󰉿",
      Method = "m",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰆧",
      Class = "󰌗",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰇽",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    }

    cmp.setup({
      view = {
        entries = {
          follow_cursor = true,
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- movements
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "bootstrap" },
        { name = "path" },
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "LSP",
            luasnip = "Snip",
            buffer = "Buffer",
            path = "Path",
          })[entry.source.name]
          return vim_item
        end,
      },
    })
  end,
}
