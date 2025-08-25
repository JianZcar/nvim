return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,  -- show inline blame
      })
    end,
  },
}
