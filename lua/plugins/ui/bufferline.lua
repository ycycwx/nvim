---@type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.o.showtabline = 2
    vim.o.tabline = " "
  end,
  opts = {
    options = {
      hover = {
        enabled = true,
        delay = 0,
        reveal = { "close" },
      },
      mode = "tabs",
      show_close_icon = false,
      buffer_close_icon = "🗙",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "aerial",
          text = "Outline",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "Outline",
          text = "Outline",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "dbui",
          text = "Database Manager",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "DiffviewFiles",
          text = "Source Control",
          text_align = "center",
          separator = true,
        },
        {
          filetype = "httpResult",
          text = "Http Result",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "OverseerList",
          text = "Tasks",
          text_align = "center",
          saperator = true,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          text_align = "center",
          saperator = true,
        },
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count)
        return "(" .. count .. ")"
      end,
      show_duplicate_prefix = false,
      always_show_bufferline = true,
      sort_by = "tabs",
    },
  },
  keys = {
    {
      "<M-1>",
      "<Cmd>BufferLineGoToBuffer 1<CR>",
      desc = "Go to tab 1",
    },
    {
      "<M-2>",
      "<Cmd>BufferLineGoToBuffer 2<CR>",
      desc = "Go to tab 2",
    },
    {
      "<M-3>",
      "<Cmd>BufferLineGoToBuffer 3<CR>",
      desc = "Go to tab 3",
    },
    {
      "<M-4>",
      "<Cmd>BufferLineGoToBuffer 4<CR>",
      desc = "Go to tab 4",
    },
    {
      "<M-5>",
      "<Cmd>BufferLineGoToBuffer 5<CR>",
      desc = "Go to tab 5",
    },
    {
      "<M-6>",
      "<Cmd>BufferLineGoToBuffer 6<CR>",
      desc = "Go to tab 6",
    },
    {
      "<M-7>",
      "<Cmd>BufferLineGoToBuffer 7<CR>",
      desc = "Go to tab 7",
    },
    {
      "<M-8>",
      "<Cmd>BufferLineGoToBuffer 8<CR>",
      desc = "Go to tab 8",
    },
    {
      "<M-9>",
      "<Cmd>BufferLineGoToBuffer 9<CR>",
      desc = "Go to tab 9",
    },

    { "<M-S-Right>", "<Cmd>+tabmove<CR>", desc = "Move tab to next" },
    { "<M-S-Left>", "<Cmd>-tabmove<CR>", desc = "Move tab to previous" },

    { "<leader>bc", "<cmd>BufferLinePickClose<CR>", desc = "Close" },
    {
      "<leader>bse",
      "<cmd>BufferLineSortByExtension<CR>",
      desc = "By extension",
    },
    {
      "<leader>bsd",
      "<cmd>BufferLineSortByDirectory<CR>",
      desc = "By directory",
    },
    { "<leader>bst", "<cmd>BufferLineSortByTabs<CR>", desc = "By tabs" },
  },
}
