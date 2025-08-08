local dap = require("dap")

dap.adapters.php = {
  type = "executable",
  command = "php-debug-adapter",
}

dap.configurations.php = {
  {
    name = "Listen for Xdebug (9003)",
    type = "php",
    request = "launch",
    port = "9003",
    hostname = "0.0.0.0",
  },
}
