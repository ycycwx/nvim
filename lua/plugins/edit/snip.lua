---@type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  keys = {
    {
      "<C-l>",
      function()
        require("luasnip").expand()
      end,
      mode = "i",
    },
  },
  opts = function()
    local snip = require "luasnip"
    local types = require "luasnip.util.types"
    local i = snip.insert_node
    local sn = snip.snippet_node

    return {
      update_events = { "TextChanged", "TextChangedI" },
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "Operator" } },
            virt_text_pos = "inline",
          },
          unvisited = {
            virt_text = { { "●", "Comment" } },
            virt_text_pos = "inline",
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "●", "Keyword" } },
            virt_text_pos = "inline",
          },
          unvisited = {
            virt_text = { { "●", "Comment" } },
            virt_text_pos = "inline",
          },
        },
      },
      snip_env = {
        -- Same with text node, used for function nodes
        text_same_with = function(args)
          return args[1][1]
        end,

        -- Same with text node, used for dynamic nodes
        insert_same_with = function(args)
          return sn(nil, {
            i(1, args[1][1]),
          })
        end,

        insert_same_with_last_path = function(args)
          local text = args[1][1]
          text = text:match "([^/]+)$"
          return sn(nil, {
            i(1, text),
          })
        end,

        -- Same with text node but append text, used for function nodes
        text_same_with_and_append = function(args, _, user_arg1)
          return args[1][1] .. user_arg1
        end,

        -- Same with text node but append text, used for dynamic nodes
        insert_same_with_and_append = function(args, _, _, user_arg1)
          return sn(nil, {
            i(1, args[1][1] .. user_arg1),
          })
        end,
      },
    }
  end,
  config = function(_, opts)
    local snip = require "luasnip"
    snip.setup(opts)

    snip.filetype_extend("cpp", { "c" })

    snip.filetype_extend("javascriptreact", { "javascript" })
    snip.filetype_extend("typescript", { "javascript" })
    snip.filetype_extend("typescriptreact", { "javascript" })

    snip.filetype_extend("typescriptreact", { "javascriptreact" })

    require("luasnip.loaders.from_lua").lazy_load {
      paths = vim.fn.stdpath "config" .. "/lua/snippets",
    }
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
