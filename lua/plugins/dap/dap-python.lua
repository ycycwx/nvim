---@type LazyPluginSpec
return {
  "mfussenegger/nvim-dap-python",
  ft = { "python" },
  config = function()
    require("dap-python").setup "debugpy-adapter"
  end,
  keys = {
    {
      "<leader>dn",
      function()
        require("dap-python").test_method()
      end,
      desc = "Test method",
    },
    {
      "<leader>df",
      function()
        require("dap-python").test_class()
      end,
      desc = "Test class",
    },
    {
      "<leader>ds",
      function()
        require("dap-python").debug_selection()
      end,
      mode = "v",
      desc = "Debug selection",
    },
  },
}
