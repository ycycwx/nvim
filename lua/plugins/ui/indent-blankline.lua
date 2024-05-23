local utils = require "utils"

-- Highlight group from rainbow-delimiters
local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

---@type LazyPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  opts = {
    indent = {
      char = "▏", -- Thiner, not suitable when enable scope
      tab_char = "▏",
    },
    scope = {
      highlight = highlight,
    },
  },
  config = function(_, opts)
    local ibl = require "ibl"
    local hooks = require "ibl.hooks"

    ibl.setup(opts)
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    -- Hide first level indent, using `foldsep` to show it
    hooks.register(hooks.type.VIRTUAL_TEXT, function(_, bufnr, row, virt_text)
      local win = vim.fn.bufwinid(bufnr)
      local lnum = row + 1
      local foldinfo = utils.fold_info(win, lnum)

      if virt_text[1] and virt_text[1][1] == opts.indent.char and foldinfo and foldinfo.start == lnum then
        virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
      end

      return virt_text
    end)
  end,
}
