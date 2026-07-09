return {
  {
    source = "obsidian-nvim/obsidian.nvim",
    depends = { "nvim-lua/plenary.nvim" },
    hooks = {
      post_install = function()
        vim.cmd("helptags ALL")
      end,
    },
  },
}
