local servers = {
  "lua_ls", "html", "cssls", "tailwindcss", "ts_ls",
  "pyright", "omnisharp", "bashls", "rust_analyzer", "gopls",
}

-- css`...` template literals inject as the 'styled' filetype
local cssls_filetypes = { "css", "scss", "less", "styled" }

local otter_extensions = { styled = "css" }
local otter_languages = { "html", "styled" }
local otter_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

vim.diagnostic.config({
  virtual_text = true,    -- show inline diagnostics
  signs = false,          -- show signs in the gutter
  update_in_insert = true,
})

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })

vim.lsp.config("cssls", { filetypes = cssls_filetypes })

require("otter").setup({ extensions = otter_extensions })

vim.api.nvim_create_autocmd("FileType", {
  pattern = otter_filetypes,
  callback = function(args)
    if vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) then
      require("otter").activate(otter_languages)
    end
  end,
})

require("trouble").setup()
