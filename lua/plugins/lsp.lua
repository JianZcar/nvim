return {
  {
    source = "mason-org/mason.nvim"
  },
  {
    source = "mason-org/mason-lspconfig.nvim",
    depends = { "neovim/nvim-lspconfig" },
  },
  {
    source = "jmbuhr/otter.nvim"
  },
  {
    source = "folke/trouble.nvim"
  },
  {
    source = "stevearc/conform.nvim"
  },
  {
    source = "mfussenegger/nvim-lint"
  },
  {
    source = "rshkarin/mason-nvim-lint",
    depends = { "mfussenegger/nvim-lint" },
  },
  {
    source = "WhoIsSethDaniel/mason-tool-installer.nvim",
    depends = { "mason-org/mason.nvim" },
  },
}
