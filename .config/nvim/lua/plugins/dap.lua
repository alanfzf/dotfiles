return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = "9008",
          hostname = "0.0.0.0",
        },
      }
    end,
  },
}
