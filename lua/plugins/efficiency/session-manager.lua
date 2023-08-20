return {
  "Shatur/neovim-session-manager",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local manager = require "session_manager"

    local config = require "session_manager.config"
    manager.setup {
      autoload_mode = config.AutoloadMode.Disabled,
    }

    -- Convert the cwd to a simple file name
    local function get_cwd_as_name()
      local dir = vim.fn.getcwd(0)
      return dir:gsub("[^A-Za-z0-9]", "_")
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "SessionSavePre",
      desc = "Save overseer tasks",
      callback = function()
        local overseer = require "overseer"

        overseer.save_task_bundle(get_cwd_as_name(), nil, { on_conflict = "overwrite" })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "SessionLoadPost",
      desc = "Load overseer tasks",
      callback = function()
        local overseer = require "overseer"

        overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
      end,
    })
  end,
  keys = {
    { "<leader>ss", "<cmd>SessionManager load_session<CR>", desc = "Load selected" },
    { "<leader>sl", "<cmd>SessionManager load_last_session<CR>", desc = "Load last" },
    { "<leader>sd", "<cmd>SessionManager delete_session<CR>", desc = "Delete" },
    -- { "<leader>scs", "<cmd>SessionManager save_current_session<CR>", desc = "Save" },
    -- { "<leader>scl", "<cmd>SessionManager load_current_dir_session<CR>", desc = "Load" },
    { "<leader>sc", "<cmd>SessionManager load_current_dir_session<CR>", desc = "Load Current" },
  },
}
