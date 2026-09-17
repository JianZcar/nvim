local config = {
  delete_to_trash = true,
  watch_for_changes = true,
  keymaps = {
    ["<Esc>"] = "actions.close",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-x>"] = "actions.select_split",
  },
  view_options = {
    show_hidden = true,
  },
  confirmation = {
    border = "single",
    width = 40,
    max_width = 40,
    min_width = 40,
    win_options = {
      winhighlight = "FloatBorder:TelescopeBorder",
    },
  },
}

require("oil").setup(config)
