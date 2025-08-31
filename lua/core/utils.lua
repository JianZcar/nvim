_G.strip_trailing_whitespace = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("%s+$", "")
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end
