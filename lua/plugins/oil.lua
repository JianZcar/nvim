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
      float = {
        padding = 2,                     -- Padding around the float
        max_width = 80,                  -- Max width of the float
        max_height = 25,                 -- Max height of the float
      },
      show_hidden = true,                 -- Show dotfiles
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "<leader>ee", require("oil").open_float, { desc = "Open File explorer" })
    end,
  }
}

