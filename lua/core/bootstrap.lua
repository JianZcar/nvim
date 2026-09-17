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
  local out = vim.fn.system(clone_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install mini.nvim: " .. tostring(out), vim.log.levels.ERROR)
  else
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.notify("Installed mini.nvim", vim.log.levels.INFO)
  end
end

require("mini.deps").setup({ path = { package = path_package } })

-- Disable unused built-in plugins for faster startup
for _, name in ipairs({
  "gzip", "matchit", "tarPlugin", "tohtml", "tutor", "zipPlugin",
}) do
  vim.g["loaded_" .. name] = true
end
