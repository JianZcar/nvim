local servers = {
  "lua_ls", "html", "cssls", "tailwindcss", "unocss", "ts_ls",
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

-- workaround: otter's completion handler assumes `data` is a table, but the
-- LSP spec allows any JSON value (tsserver returns a number) -> strip non-tables
local otter_handlers = require("otter.lsp.handlers")
local otter_method = vim.lsp.protocol.Methods.textDocument_completion
local otter_orig = otter_handlers[otter_method]

local function strip_item_data(res)
  if type(res) ~= "table" then
    return
  end
  for _, item in ipairs(res.items or res) do
    if type(item.data) ~= "table" then
      item.data = nil
    end
  end
end

otter_handlers[otter_method] = function(err, res, ctx)
  strip_item_data(res)
  return otter_orig(err, res, ctx)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = otter_filetypes,
  callback = function(args)
    if vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) then
      require("otter").activate(otter_languages)
    end
  end,
})

require("trouble").setup()
