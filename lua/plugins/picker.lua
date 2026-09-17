return {
  {
    source = "nvim-telescope/telescope.nvim",
    depends = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  },
  { source = "nvim-telescope/telescope-ui-select.nvim" },
  { source = "MagicDuck/grug-far.nvim" },
  {
    source = "nvim-telescope/telescope-fzf-native.nvim",
    hooks = {
      post_install = function(h)
        vim.fn.system("make -C " .. h.path)
      end,
      post_checkout = function(h)
        vim.fn.system("make -C " .. h.path)
      end,
    },
  },
}
