return {
  {
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
  },
  {
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main"
  },
  {
    source = "windwp/nvim-ts-autotag"
  },
  {
    source = "JoosepAlviste/nvim-ts-context-commentstring"
  },
  {
    source = "samjwill/nvim-unception"
  },
  {
    source = "echasnovski/mini.surround"
  },
  {
    source = "echasnovski/mini.comment"
  },
  {
    source = "folke/flash.nvim"
  }
}
