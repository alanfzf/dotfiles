return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json" },
  init_options = {
    globalStoragePath = vim.fn.expand("$HOME/.intelephense"),
    licenceKey = vim.fn.expand("$HOME/.intelephense/licence.txt"),
  },
}
