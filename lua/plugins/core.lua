return {
  {
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  },
  {
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main"
  },
  {
    source = "williamboman/mason.nvim",
  },
  {
    source = "daliusd/incr.nvim",
  }
}
