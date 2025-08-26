return {
  {
    "j-morano/buffer_manager.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local bm = require("buffer_manager")
      -- Optional configuration
      bm.setup({
        show_indicators = "after"
      })
    end,
  }
}
