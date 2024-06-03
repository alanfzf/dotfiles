return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "/home/dev/.local/share/nvim/mason/bin/php-debug-adapter",
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
