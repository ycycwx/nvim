return {
  "3rd/image.nvim",
  enabled = vim.uv.os_uname().sysname ~= "Windows_NT",
  init = function()
    package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.nix-profile/share/lua/5.1/?/init.lua;"
    package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.nix-profile/share/lua/5.1/?.lua;"
  end,
  event = "VeryLazy",
  opts = {},
}
