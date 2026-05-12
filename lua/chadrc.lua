local M = {}

M.base46 = {
  theme = "ayu_light",
}
M.ui = {
  cmp = {
    lspkind_text = true,
    style = "flat_dark",
    format_colors = {
      lsp = true,
    },
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
