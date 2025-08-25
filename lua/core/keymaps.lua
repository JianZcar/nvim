local keymap = vim.keymap

-- Oil keymaps
keymap.set("n", "<leader>ee", require("oil").open_float, { desc = "Open File explorer" })

-- Telescope keymaps
keymap.set("n", "<leader>bf", require("utils.telescope").pick_buffers_filtered, { desc = "Find buffers" })
keymap.set("n", "<leader>ef", require("telescope.builtin").find_files, { desc = "Find files" })
keymap.set("n", "<leader>sc", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "Search in current buffer" })
keymap.set("n", "<leader>sb", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Search in all buffers" })
keymap.set("n", "<leader>sf", require("telescope.builtin").live_grep, { desc = "Search in all files" })

-- LSP keymaps
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
