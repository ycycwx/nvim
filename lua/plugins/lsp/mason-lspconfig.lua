---@type LazyPluginSpec
return {
  "williamboman/mason-lspconfig.nvim",
  event = {
    "Filetype",
  },
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",

    "b0o/SchemaStore.nvim",
    "nanotee/sqls.nvim",
  },
  opts = function()
    local lspconfig = require "lspconfig"

    return {
      handlers = {
        function(server)
          lspconfig[server].setup {}
        end,

        rust_analyzer = function() end,
        jdtls = function() end,

        lua_ls = function()
          lspconfig.lua_ls.setup {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                hint = {
                  enable = true,
                  setType = true,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  postfix = ".",
                  showWord = "Disable",
                  workspaceWord = false,
                },
                diagnostics = {
                  disable = {
                    "unused-function",
                    "empty-block",
                  },
                },
              },
            },
          }
        end,

        gopls = function()
          lspconfig.gopls.setup {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
          }
        end,

        zls = function()
          lspconfig.zls.setup {
            settings = {
              zls = {
                inlay_hints_hide_redundant_param_names = true,
                inlay_hints_hide_redundant_param_names_last_token = true,
                warn_style = true,
                highlight_global_var_declarations = true,
              },
            },
          }
        end,

        vtsls = function()
          local loaded, vtsls = pcall(require, "vtsls")
          if loaded then
            require("lspconfig.configs").vtsls = vtsls.lspconfig
          end
          lspconfig.vtsls.setup {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
            settings = {
              vtsls = {
                autoUseWorkspaceTsdk = true,
              },
              typescript = {
                preferences = {
                  importModuleSpecifier = "non-relative",
                },
                inlayHints = {
                  enumMemberValues = {
                    enabled = true,
                  },
                  functionLikeReturnTypes = {
                    enabled = true,
                  },
                  parameterNames = {
                    enabled = "all",
                    suppressWhenArgumentMatchesName = true,
                  },
                  parameterTypes = {
                    enabled = true,
                  },
                  propertyDeclarationTypes = {
                    enabled = true,
                  },
                  variableTypes = {
                    enabled = true,
                    suppressWhenTypeMatchesName = true,
                  },
                },
              },
            },
          }
        end,

        volar = function()
          lspconfig.volar.setup {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
          }
        end,

        jsonls = function()
          lspconfig.jsonls.setup {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
            end,
          }
        end,

        yamlls = function()
          lspconfig.yamlls.setup {
            settings = {
              yaml = {
                keyOrdering = false,
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas {
                  ignore = {
                    -- Very easy to conflict with other `deploy.yaml`
                    "Deployer Recipe",
                  },
                },
              },
            },
          }
        end,

        sqls = function()
          lspconfig.sqls.setup {
            on_attach = function(client, bufnr)
              require("sqls").on_attach(client, bufnr)
            end,
          }
        end,
      },
    }
  end,
}
