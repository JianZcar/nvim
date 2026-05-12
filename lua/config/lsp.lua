local servers = { "lua_ls", "html", "cssls", "tailwindcss", "ts_ls", "pylsp", "omnisharp", "bashls", "rust_analyzer", "gopls", }

vim.diagnostic.config({
  virtual_text = true,    -- show inline diagnostics
  signs = false,          -- show signs in the gutter
  update_in_insert = true,
})

vim.lsp.config("qml-language-server", {
  cmd = { "qml-language-server" },
  filetypes = { "qml" },
  root_markers = { { "qmldir", "shell.qml" }, ".git" },
})

vim.lsp.enable("qml-language-server")

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })
require("trouble").setup()
