local keymap = vim.keymap

keymap.set("n", "<leader>w", ":write<CR>")

-- Oil keymaps
keymap.set("n", "<leader>fe", require("oil").open, { desc = "Open File explorer" })

-- Buffer manager
keymap.set("n", "<leader>bb", require("buffer_manager.ui").toggle_quick_menu, { desc = "Open Buffer Manager" })
keymap.set("n", '<Tab>', ":bnext<CR>", { desc = "Next Buffer"})
keymap.set("n", '<S-Tab>', ":bprev<CR>", { desc = "Previous Buffer"})

-- Telescope keymaps
keymap.set("n", "<leader>bf", require("utils.telescope").pick_buffers_filtered, { desc = "Find buffers" })
keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
keymap.set("n", "<leader>sc", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "Search in current buffer" })
keymap.set("n", "<leader>sb", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Search in all buffers" })
keymap.set("n", "<leader>sf", require("telescope.builtin").live_grep, { desc = "Search in all files" })

-- LSP keymaps
keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename" })
keymap.set("n", "<leader>H", vim.lsp.buf.hover, { desc = "Hover" })
