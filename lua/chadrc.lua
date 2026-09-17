local M = {}

M.base46 = {
  theme = "ayu_light",
  excluded = { "cmp", "nvimtree", "nvcheatsheet", "tbline" },
}
M.ui = {
  cmp = {
    style = "flat_dark",
  },
  statusline = {
    theme = "vscode_colored"
  },
  tabufline = { enabled = false }
}
M.lsp = {
  signature = false,
}

return M
