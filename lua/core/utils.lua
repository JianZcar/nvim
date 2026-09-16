local M = {}

function M.strip_trailing_whitespace(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("%s+$", "")
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
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
    end
  end
end

return M