return {
  {
    source = "nickjvandyke/opencode.nvim",
    hooks = {
      post_install = function()
        vim.cmd("helptags ALL")
      end,
    },
  },
}
