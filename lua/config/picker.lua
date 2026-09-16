require("grug-far").setup()

vim.keymap.set("n", "<leader>fr", function()
  require("grug-far").open()
end, { desc = "Find & replace" })