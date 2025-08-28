local keymap = vim.keymap

-- Window movement
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize splits
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

keymap.set("n", "<leader>w", ":write<CR>")
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })

-- Oil keymaps

keymap.set("n", "<leader>-", function()
  local oil = require("oil")
  local ok = pcall(oil.toggle_float)
  if not ok then
    oil.toggle_float(vim.loop.cwd())
  end
end, { desc = "Open File explorer" })

keymap.set("n", "<leader>_", function()
  require("oil").toggle_float(vim.loop.cwd())
end, { desc = "Open File explorer (cwd)" })



-- Buffer manager
keymap.set("n", "<leader>fe", require("telescope.builtin").buffers, { desc = "Find buffers" })
keymap.set("n", '<Tab>', ":bnext<CR>", { desc = "Next Buffer" })
keymap.set("n", '<S-Tab>', ":bprev<CR>", { desc = "Previous Buffer" })
keymap.set("n", '<leader>x', ":bnext | bprevious | bd<CR>", { desc = "Close Buffer" })
keymap.set("n", '<leader>X', ":bnext | bprevious | bd!<CR>", { desc = "Force Close Buffer" })
keymap.set("n", '<leader>c', ":close<CR>", { desc = "Close Window" })

keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
keymap.set("n", "<leader>sc", require("telescope.builtin").current_buffer_fuzzy_find,
  { desc = "Search in current buffer" })
keymap.set("n", "<leader>sb", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Search in all buffers" })
keymap.set("n", "<leader>sf", require("telescope.builtin").live_grep, { desc = "Search in all files" })

-- LSP keymaps
keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename" })
keymap.set("n", "<leader>H", vim.lsp.buf.hover, { desc = "Hover" })
keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format()
end, { desc = "Format buffer with LSP" })



keymap.set("n", '<leader>t', ":term<CR>", { desc = "Open Terminal" })
