local custom = require "custom"

---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  event = {
    "Filetype",
  },
  dependencies = {
    "folke/neoconf.nvim",
  },
  config = function()
    require("lspconfig.ui.windows").default_options.border = custom.border
    local lspconfig = require "lspconfig"

    --[[
    lspconfig.nixd.setup {
      settings = {
        nixd = {
          nixpkgs = {
            expr = 'import (builtins.getFlake "/home/ofseed/flake").inputs.nixpkgs {  }',
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "/home/ofseed/flake").nixosConfigurations.ofseed.options',
            },
            home_manager = {
              expr = '(builtins.getFlake "/home/ofseed/flake").homeConfigurations.ofseed.options',
            },
          },
        },
      },
    }
    --]]

    lspconfig.pyright.setup {
      cmd = { "delance-langserver", "--stdio" },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
            inlayHints = {
              callArgumentNames = "partial",
              functionReturnTypes = true,
              pytestParameters = true,
              variableTypes = true,
            },
          },
        },
      },
    }

    lspconfig.clangd.setup {
      cmd = { "clangd", "--header-insertion-decorators=0" },
    }
  end,
  keys = {
    {
      "<leader>lR",
      function()
        vim.cmd.LspRestart()
      end,
      desc = "Reload",
    },
    {
      "<leader>lI",
      function()
        vim.cmd.LspInfo()
      end,
      desc = "Info",
    },
  },
}
