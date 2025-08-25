return {
  {
    "j-morano/buffer_manager.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local bm = require("buffer_manager")
      
      -- Optional configuration
      bm.setup({
        sort_by = "id",                 -- Sort buffers by id
        floating = {
          width = 80,
          height = 25,
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>bb", function()
        require("buffer_manager.ui").toggle_quick_menu()
      end, { desc = "Open Buffer Manager" })
    end,
  }
}
