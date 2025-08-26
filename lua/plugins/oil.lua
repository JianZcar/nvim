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

