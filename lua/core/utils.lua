_G.strip_trailing_whitespace = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("%s+$", "")
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

_G.when_loaded = function(fn)
  return function(...)
    if vim.g.loading_done then
      return fn(...)
    end
  end
end

_G.cmd_when_loaded = function(cmd)
  return function()
    if vim.g.loading_done then
      vim.cmd(cmd)
    end
  end
end
