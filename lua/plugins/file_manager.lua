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

            local actions = require("oil.actions")
            actions.parent.callback()
          end,
        },
        ["_"] = "actions.open_cwd",

        ["f"] = {
          callback = function()
            local oil = require("oil")
            local telescope = require("telescope.builtin")

            telescope.find_files({
              cwd = oil.get_current_dir(0),
            })
          end,
        },

        ["<CR>"] = "actions.select",         -- Enter directory or open file
        ["<Esc>"] = "actions.close",         -- Escape closes the float
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
      win_options = {
        winblend = 0,
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:Bold",
      },
      float = {
        padding = 0,
        border = "rounded",
        max_width = 70,
        max_height = 15,
        get_win_title = function(_)
          local oil = require("oil")
          local dir = oil.get_current_dir(0) -- 0 = current buffer
          if not dir then
            return ""
          end

          -- Use cwd as root
          local cwd = vim.loop.cwd()
          local rel = vim.fn.fnamemodify(dir, ":.")
          if rel == "." then
            return vim.fn.fnamemodify(cwd, ":t") .. "/"
          else
            return vim.fn.fnamemodify(cwd, ":t") .. "/" .. rel
          end
        end,
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
