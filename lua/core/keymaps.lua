-- Key mappings
vim.g.mapleader = " "                              -- Set leader key to space
vim.g.maplocalleader = " "                         -- Set local leader key (NEW)

-- Insert mode mappings
vim.keymap.set("i", ";;", "<Esc>", { desc = "Normal Mode" })
vim.keymap.set("i", "::", "<Esc>v", { desc = "Visual Mode" })

-- Visual mode mappings

-- Normal mode mappings
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find file" })
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
vim.keymap.set("n", "<leader>[", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>]", ":bprevious<CR>", { desc = "Previous buffer" })

-- Tab navigation
vim.keymap.set("n", "<leader><Tab>", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { desc = "Previous tab" })

vim.keymap.set("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

vim.keymap.set("n", "<leader>e", function()
  require("oil").open(nil, {
    preview = { vertical = true }  -- opens preview in a vertical split
  })
end, { desc = "Open File Manager" })
