require("core.bootstrap")
require("plugins")

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require("core.options")
  require("core.keymaps")
  require("core.autocommands")

  require("config.ui")
  require("config.lsp")
  require("config.file-manager")
end)
