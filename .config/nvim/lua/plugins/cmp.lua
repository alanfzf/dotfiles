return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-path"},
    {"saadparwaiz1/cmp_luasnip"},
    {
      "Jezda1337/cmp_bootstrap",
      config = function ()
        require("bootstrap-cmp.config"):setup({
          file_types = { "html", "javascriptreact", "jsx", "htmldjango"},
        })
      end
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
  },
  config = function()
    local cmp = require("cmp")
    local lua_snip = require("luasnip")
    local snip_loader = require('luasnip/loaders/from_vscode')
    -- Load my snippets
    -- Im 100% sure this is bad, and it can be achieved in a better way but i couldn't find the proper way.
    snip_loader.lazy_load()
    snip_loader.lazy_load({paths=vim.fn.stdpath("config").. "/snippets/" })
    -- additional configs
    lua_snip.filetype_extend("php", {"phpdoc"})


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
      snippet = {
        expand = function(args)
          lua_snip.lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        -- movements
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<CR>'] = cmp.mapping.confirm({ select = false}),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'bootstrap' },
        { name = 'path'}
      },
      formatting = {
        fields = { "abbr","kind", "menu" },
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
  end
}
