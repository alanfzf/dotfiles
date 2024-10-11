return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  version = "v0.*",
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- On musl libc based systems you need to add this flag
  -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

  opts = {
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    keymap = {
      accept = "<CR>",
    },

    nerd_font_variant = "normal",

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    -- experimental signature help support
    -- trigger = { signature_help = { enabled = true } }

    -- ** start sources **
    sources = {
      providers = {
        {
          { "blink.cmp.sources.lsp" },
          { "blink.cmp.sources.path" },
          { "blink.cmp.sources.snippets", score_offset = -3 },
        },
        { { "blink.cmp.sources.buffer" } },
      },
    },
    -- ** end sources **
  },
}
