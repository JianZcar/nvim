-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Normal: save / quit / misc
vim.keymap.set("t", ";;", [[<C-\><C-n>]], { noremap = true })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })
vim.keymap.set("n", "<leader>W", ":wa<CR>", { desc = "Save all" })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>C", ":nohlsearch<CR>", { desc = "Clear highlights" })

-- Centered navigation
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Buffers
vim.keymap.set("n", "<Tab>", when_loaded(function()
  vim.api.nvim_feedkeys("<Plug>(CybuNext)", "m", false)
end), { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", when_loaded(function()
  vim.api.nvim_feedkeys("<Plug>(CybuPrev)", "m", false)
end), { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bc", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("bprev")
  vim.api.nvim_buf_delete(bufnr, { force = true })
end, { desc = "Close buffer" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader><Tab>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader><S-Tab>", ":tabprevious<CR>", { desc = "Prev tab" })

-- Theme picker
vim.keymap.set("n", "<leader>ft", when_loaded(function()
  require("nvchad.themes").open()
end), { desc = "Pick theme" })

-- Files
vim.keymap.set("n", "<leader>e", when_loaded(function()
  require("oil").open(nil, { preview = { vertical = true } })
end), { desc = "Explore files" })
vim.keymap.set("n", "<leader>E", when_loaded(function()
  require("oil").open(vim.fn.getcwd(), { preview = { vertical = true } })
end), { desc = "Explore cwd" })

-- Telescope shortcuts
vim.keymap.set("n", "<leader>ff", when_loaded(function()
  require("telescope.builtin").find_files()
end), { desc = "Find file" })

vim.keymap.set("n", "<leader>fg", when_loaded(function()
  require("telescope.builtin").live_grep()
end), { desc = "Live grep" })

vim.keymap.set("n", "<leader>bb", when_loaded(function()
  require("telescope.builtin").buffers()
end), { desc = "List buffers" })

vim.keymap.set("n", "<leader>gt", when_loaded(function()
  require("telescope.builtin").git_status()
end), { desc = "Git status" })

-- LSP
vim.keymap.set("n", "<leader>lr", require("nvchad.lsp.renamer"), { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover doc" })

-- Formatting
local lsp_format = function()
  strip_trailing_whitespace()
  vim.lsp.buf.format({ async = true })
end
vim.keymap.set("n", "<leader>lf", lsp_format, { desc = "Format buffer" })
vim.keymap.set("v", "<leader>lf", lsp_format, { desc = "Format selection" })

-- Trouble
vim.keymap.set("n", "<leader>xx", cmd_when_loaded("Trouble diagnostics toggle"), { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>xw", cmd_when_loaded("Trouble diagnostics toggle filter.buf=0"), { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>xl", cmd_when_loaded("Trouble loclist toggle"), { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", cmd_when_loaded("Trouble qflist toggle"), { desc = "Quickfix list" })

-- Screenkey
vim.keymap.set("n", "<leader>st", when_loaded(function()
  require("screenkey").toggle()
end), { desc = "Toggle screenkey" })

-- Obsidian
vim.keymap.set("n", "<leader>oo", cmd_when_loaded("Obsidian today"), { desc = "Today's daily note" })
vim.keymap.set("n", "<leader>os", cmd_when_loaded("Obsidian search"), { desc = "Search notes" })
vim.keymap.set("n", "<leader>oq", cmd_when_loaded("Obsidian quick_switch"), { desc = "Quick switch notes" })
vim.keymap.set("n", "<leader>ol", cmd_when_loaded("Obsidian open"), { desc = "Open note" })
vim.keymap.set("n", "<leader>od", cmd_when_loaded("Obsidian dailies"), { desc = "Dailies picker" })
vim.keymap.set("n", "<leader>on", cmd_when_loaded("Obsidian new"), { desc = "New note" })
vim.keymap.set("n", "<leader>ot", cmd_when_loaded("Obsidian tags"), { desc = "Tags picker" })
vim.keymap.set("n", "<leader>ob", cmd_when_loaded("Obsidian backlinks"), { desc = "Backlinks" })
vim.keymap.set("n", "<leader>o.", cmd_when_loaded("Obsidian follow_link"), { desc = "Follow link" })
vim.keymap.set("n", "<leader>o,", cmd_when_loaded("Obsidian toc"), { desc = "Table of contents" })
vim.keymap.set("n", "<leader>of", cmd_when_loaded("Obsidian footnotes"), { desc = "Footnotes" })
vim.keymap.set("n", "<leader>oi", cmd_when_loaded("Obsidian paste_img"), { desc = "Paste image" })
vim.keymap.set("n", "<leader>or", cmd_when_loaded("Obsidian rename"), { desc = "Rename note" })
vim.keymap.set("n", "<leader>ox", cmd_when_loaded("Obsidian toggle_checkbox"), { desc = "Toggle checkbox" })
vim.keymap.set("n", "<leader>otm", cmd_when_loaded("Obsidian template"), { desc = "Insert template" })
vim.keymap.set("n", "<leader>oun", cmd_when_loaded("Obsidian unique_note"), { desc = "New unique note" })
vim.keymap.set("n", "<leader>ouw", cmd_when_loaded("Obsidian workspace"), { desc = "Switch workspace" })
vim.keymap.set("v", "<leader>oe", cmd_when_loaded("Obsidian extract_note"), { desc = "Extract note" })
vim.keymap.set("v", "<leader>ol", cmd_when_loaded("Obsidian link"), { desc = "Link selection" })

-- Treesitter Textobjects
vim.keymap.set({ "x", "o" }, "af", when_loaded(function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end), { desc = "Function outer" })

vim.keymap.set({ "x", "o" }, "if", when_loaded(function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end), { desc = "Function inner" })

vim.keymap.set({ "x", "o" }, "ac", when_loaded(function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end), { desc = "Class outer" })

vim.keymap.set({ "x", "o" }, "ic", when_loaded(function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end), { desc = "Class inner" })

vim.keymap.set("n", "<leader>a", when_loaded(function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end), { desc = "Swap next param" })

vim.keymap.set("n", "<leader>A", when_loaded(function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end), { desc = "Swap prev param" })
