local utils = require("core.utils")

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    local skip = ft == "markdown" or ft == "text" or ft == "help"
    if not skip and vim.bo.modifiable and vim.bo.modified then
      utils.strip_trailing_whitespace()
    end
  end,
})
