-- Bootstrap base46
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- Bootstrap Mini.deps
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.notify("Installing mini.nvim...", vim.log.levels.INFO)
  local clone_cmd = {
    "git", "clone", "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim", mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.notify("Installed mini.nvim", vim.log.levels.INFO)
end

require("mini.deps").setup({ path = { package = path_package } })
