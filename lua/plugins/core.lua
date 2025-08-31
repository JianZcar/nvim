return {
  {
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    monitor = "main",
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  },
  {
    source = "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    source = "williamboman/mason.nvim",
  },
}
