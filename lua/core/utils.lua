local M = {}

-- Clear only nvim-lint diagnostics for a buffer (LSP diagnostics untouched).
function M.clear_lint_diagnostics(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  local ok, lint = pcall(require, "lint")
  if not ok then
    return
  end
  for _, name in ipairs(lint.linters_by_ft[vim.bo[bufnr].filetype] or {}) do
    vim.diagnostic.reset(lint.get_namespace(name), bufnr)
  end
end

local function package_ready(mod)
  if package.loaded[mod] ~= nil then
    return true
  end
  return pcall(require, mod) and true
end

function M.when_loaded(mod, fn)
  return function(...)
    if package_ready(mod) then
      return fn(...)
    end
  end
end

function M.cmd_when_loaded(mod, cmd)
  return function()
    if package_ready(mod) then
      vim.cmd(cmd)
    else
      vim.notify(mod .. " is not available", vim.log.levels.WARN)
    end
  end
end

return M