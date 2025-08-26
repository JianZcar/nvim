return {
  {
    "j-morano/buffer_manager.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local bm = require("buffer_manager")
      -- Optional configuration
      bm.setup({
        show_indicators = "after",
        select_menu_item_commands = {
          v = { key = "<C-v>", command = "vsplit" },   -- Ctrl+V for vertical split
          h = { key = "<C-s>", command = "split" },    -- Ctrl+H for horizontal split
        },
      })
    end,
  }
}
