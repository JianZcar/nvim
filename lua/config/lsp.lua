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
  virtual_text = true,
  signs = false,
  severity_sort = true,
  update_in_insert = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink_caps = pcall(require, "blink.cmp")
if ok_blink and blink_caps.get_lsp_capabilities then
  capabilities = blink_caps.get_lsp_capabilities(capabilities)
end
-- Apply to all servers configured below via vim.lsp.config('*', ...)
vim.lsp.config("*", { capabilities = capabilities })

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers, automatic_enable = true })
vim.lsp.enable(servers)

vim.lsp.config("cssls", {
  filetypes = cssls_filetypes,
  settings = {
    css = { lint = {} },
    scss = { lint = {} },
    less = { lint = {} },
    styled = { lint = {} },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = { staticcheck = true },
  },
})

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      typeCheckingMode = "basic",
    },
  },
})

require("otter").setup({ extensions = otter_extensions })

-- otter assumes item.data is a table, but the spec allows any JSON value
-- (unocss sends a number) and indexing it crashes completion.
local otter_handlers = require("otter.lsp.handlers")
local completion_method = "textDocument/completion"
local completion_orig = otter_handlers[completion_method]
otter_handlers[completion_method] = function(err, res, ctx)
  local items = type(res) == "table" and (res.items or res) or nil
  if type(items) == "table" then
    for _, item in ipairs(items) do
      if type(item) == "table" and type(item.data) ~= "table" then
        item.data = nil
      end
    end
  end
  return completion_orig(err, res, ctx)
end

local otter_group = vim.api.nvim_create_augroup("UserOtter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = otter_group,
  pattern = otter_filetypes,
  callback = function(args)
    if vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) then
      require("otter").activate(otter_languages)
    end
  end,
})

require("trouble").setup()

local formatters_by_ft = {
  bash = { "shfmt" },
  sh = { "shfmt" },
  css = { "prettierd", "prettier", stop_after_first = true },
  go = { "gofmt" },
  html = { "prettierd", "prettier", stop_after_first = true },
  javascript = { "prettierd", "prettier", stop_after_first = true },
  javascriptreact = { "prettierd", "prettier", stop_after_first = true },
  json = { "prettierd", "prettier", stop_after_first = true },
  jsonc = { "prettierd", "prettier", stop_after_first = true },
  less = { "prettierd", "prettier", stop_after_first = true },
  lua = { "stylua" },
  markdown = { "prettierd", "prettier", stop_after_first = true },
  python = { "isort", "black" },
  rust = { "rustfmt" },
  scss = { "prettierd", "prettier", stop_after_first = true },
  styled = { "prettierd", "prettier", stop_after_first = true },
  typescript = { "prettierd", "prettier", stop_after_first = true },
  typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  yaml = { "yamlfmt", "prettierd", "prettier", stop_after_first = true },
  toml = { "taplo" },
  ["_"] = { "trim_whitespace" },
}

require("conform").setup({
  formatters_by_ft = formatters_by_ft,
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformat-on-save", bang = true })
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("lint").linters_by_ft = {
  dockerfile = { "hadolint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  lua = { "luacheck" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  yaml = { "yamllint" },
}

require("mason-nvim-lint").setup({
  automatic_installation = true,
})

local ok_tool_installer, tool_installer = pcall(require, "mason-tool-installer")
if ok_tool_installer then
  tool_installer.setup({
    ensure_installed = {
      "prettierd", "prettier", "stylua", "black", "isort",
      "shfmt", "gofmt", "yamlfmt", "taplo",
      "shellcheck", "hadolint", "luacheck", "eslint_d", "yamllint",
    },
  })
end

local lint_group = vim.api.nvim_create_augroup("UserLint", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  group = lint_group,
  callback = function(args)
    if vim.g.disable_lint or vim.b[args.buf].disable_lint then
      return
    end
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    vim.schedule(require("lint").try_lint)
  end,
})

vim.api.nvim_create_user_command("LintDisable", function(args)
  if args.bang then
    vim.b.disable_lint = true
    require("core.utils").clear_lint_diagnostics(0)
  else
    vim.g.disable_lint = true
    require("core.utils").clear_lint_diagnostics()
  end
end, { desc = "Disable lint suggestions", bang = true })
vim.api.nvim_create_user_command("LintEnable", function()
  vim.b.disable_lint = false
  vim.g.disable_lint = false
  require("lint").try_lint()
end, { desc = "Re-enable lint suggestions" })

-- Register LSP keymaps per-buffer so they only exist when an LSP is attached
local lsp_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    require("core.keymaps").lsp_maps(args.buf)
  end,
})
