require("core.options")
require("core.mini-deps")
require("plugins")

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require("core.keymaps")
  require("config.ui")
  require("config.lsp")
end)

later(function()
end)
