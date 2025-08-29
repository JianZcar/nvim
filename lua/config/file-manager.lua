local config = {
  delete_to_trash = true,
  watch_for_changes = true,
  keymaps = {
    ["<Esc>"] = "actions.close",         -- Escape closes the float
    ["<C-v>"] = "actions.select_vsplit", -- Open in vertical split
    ["<C-s>"] = "actions.select_split",  -- Open in horizontal split
  },
  view_options = {
    show_hidden = true,
  },
  confirmation = {
    border = "none",
    win_options = {
      winblend = 10,
    },
  },
}

require("oil").setup(config)
