local servers = { "lua_ls", "html", "cssls", "tailwindcss", "ts_ls", "pyright", "omnisharp", "bashls", "rust_analyzer", "gopls", }

vim.diagnostic.config({
  virtual_text = true,    -- show inline diagnostics
  signs = false,          -- show signs in the gutter
  update_in_insert = true,
})

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })
require("trouble").setup()
