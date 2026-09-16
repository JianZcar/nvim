require("core.bootstrap")
require("plugins")

local now, later = MiniDeps.now, MiniDeps.later

vim.o.title = true
vim.opt.shortmess:append("I")

now(function()
  require("config.ui")
  require("core.utils")
  require("core.options")
  require("core.keymaps")
  require("core.autocommands")
end)

later(function()
  local function load(name)
    local ok, err = pcall(require, name)
    if not ok then
      vim.notify("Failed to load " .. name .. ": " .. tostring(err), vim.log.levels.ERROR)
    end
  end

  load("config.treesitter")
  load("config.lsp")
  load("config.autocomplete")
  load("config.file-manager")
  load("config.picker")
  load("config.obsidian")
  load("config.opencode")
  load("config.git")
end)
