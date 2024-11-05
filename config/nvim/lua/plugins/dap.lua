return {
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    config = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
      }

      dap.configurations.php = {
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
