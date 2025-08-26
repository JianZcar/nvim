return {
  -- Oil file explorer
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      keymaps = {
        ["-"] = "dir_up",                -- Go to parent directory
        ["<CR>"] = "actions.select",     -- Enter directory or open file
        ["<Esc>"] = "actions.close",     -- Escape closes the float
        ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
        ["<C-s>"] = "actions.select_split",  -- Open in horizontal split
      },
      view_options = {
        show_hidden = true,                 -- Show dotfiles
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  }
}

