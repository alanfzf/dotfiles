return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
      }

      dap.configurations.php = {
        {
          name = "Listen for Xdebug backend (9008)",
          type = "php",
          request = "launch",
          port = "9008",
          hostname = "0.0.0.0",
        },
        {
          name = "Listen for Xdebug frontend (9005)",
          type = "php",
          request = "launch",
          port = "9005",
          hostname = "0.0.0.0",
        },
      }
    end,
  },
}
