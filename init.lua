require("core.bootstrap")
require("plugins")

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

vim.o.title = true

now(function()
  require("core.utils")
  require("core.options")
  require("core.keymaps")
  require("core.autocommands")

  require("config.ui")
end)

later(function()
  pcall(require, "config.treesitter")
  pcall(require, "config.lsp")
  pcall(require, "config.autocomplete")
  pcall(require, "config.file-manager")
  pcall(require, "config.obsidian")
end)
