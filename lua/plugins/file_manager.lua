return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      delete_to_trash = true,
      watch_for_changes = true,
      keymaps = {
        ["g?"] = "actions.show_help",

        ["-"] = {
          callback = function()
            local o = require("oil")
            local fn = vim.fn

            local function norm(p)
              if not p or p == "" then return "" end
              return fn.fnamemodify(p, ":p"):gsub("/+$", "")
            end

            local cur = o.get_current_dir(0) or vim.loop.cwd()
            cur = norm(cur)
            local root = norm(vim.loop.cwd())

            if cur == root then
              return
            end

            local parent = norm(fn.fnamemodify(cur, ":h"))
            -- use oil.open to switch to the parent directory
            pcall(o.open, parent)
          end,
          mode = "n",
          desc = "Oil: parent but do not go above CWD",
        },

        ["<CR>"] = "actions.select",     -- Enter directory or open file
        ["<Esc>"] = "actions.close",     -- Escape closes the float
        ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
        ["<C-s>"] = "actions.select_split",  -- Open in horizontal split
      },
      use_default_keymaps = false,
      view_options = {
        is_hidden_file = function(name, bufnr)
          return name == ".."
        end
      },
      preview_win = {
        disable_preview = function(filename)
          return true
        end,
      },
      float = {
        padding = 2,
        max_width = 0.4,
        max_height = 0.4,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
  {
  "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
  }
}

