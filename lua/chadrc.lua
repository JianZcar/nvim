local M = {}

M.base46 = {
	theme = "one_light",
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

return M
