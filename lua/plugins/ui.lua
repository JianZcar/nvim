return {
  {
    source = "nvchad/ui",
  },
  {
    source = "nvim-lualine/lualine.nvim",
    depends = { "nvim-tree/nvim-web-devicons" }
  },
  {
    source = "lewis6991/gitsigns.nvim",
  },
  {
    source = "saghen/blink.cmp",
    depends = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip", "xzbdmw/colorful-menu.nvim" },
    checkout = "v1.6.0"
  },
  {
    source = "folke/which-key.nvim",
  }
}
