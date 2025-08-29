return {
  {
    source = "nvim-lualine/lualine.nvim",
    depends = { "nvim-tree/nvim-web-devicons" }
  },
  {
    source = "lewis6991/gitsigns.nvim",
  },
  {
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim",
      "onsails/lspkind-nvim"
    },
    checkout = "v1.6.0"
  },
  {
    source = "folke/which-key.nvim",
  }
}
