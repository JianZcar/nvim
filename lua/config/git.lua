require("gitsigns").setup({
  current_line_blame = true,
})

-- Calling the Lua function directly is more robust than :LazyGit: it works
-- regardless of whether the plugin/ script has been sourced.
vim.keymap.set("n", "<leader>gg", function()
  require("lazygit").lazygit()
end, { desc = "Open lazygit" })