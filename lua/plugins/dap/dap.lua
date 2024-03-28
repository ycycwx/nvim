vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant", linehl = "debugPC" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "jay-babu/mason-nvim-dap.nvim",
    "LiadOz/nvim-dap-repl-highlights",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require "dap"
    dap.defaults.fallback.external_terminal = {
      command = "/usr/bin/kitty",
      args = { "--class", "kitty-dap", "--hold", "--detach", "nvim-dap", "-c", "DAP" },
    }

    dap.adapters["nvim-lua"] = function(callback, config)
      callback {
        type = "server",
        host = config.host or "127.0.0.1",
        port = config.port or 8086,
      }
    end
    dap.configurations.lua = {
      {
        type = "nvim-lua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap" },
    }
    -- dap.configurations.cpp = {
    --   {
    --     name = "Launch",
    --     type = "gdb",
    --     request = "launch",
    --     program = "${fileBasenameNoExtension}",
    --     cwd = "${workspaceFolder}",
    --     stopAtBeginningOfMainSubprogram = false,
    --     preLaunchTask = "C++ build single file",
    --   },
    -- }

    ---@diagnostic disable-next-line: undefined-field
    require("overseer").patch_dap(true)
    require("dap.ext.vscode").json_decode = require("overseer.json").decode
  end,
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step into",
    },
    {
      "<F23>", -- Shift + <F11>
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step out",
    },
    {
      "<F9>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle breakpoint",
    },

    {
      "<leader>dp",
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "Set breakpoint",
    },
    {
      "<leader>dP",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end,
      desc = "Set log point",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run last",
    },
  },
}
