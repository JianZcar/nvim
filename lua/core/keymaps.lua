-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local utils = require("core.utils")
local when_loaded, cmd_when_loaded = utils.when_loaded, utils.cmd_when_loaded

local M = {}

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

-- Create windows / buffers
vim.keymap.set("n", "<leader>h", ":split<CR>", { desc = "New horizontal window" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "New vertical window" })

-- Buffers
vim.keymap.set("n", "<Tab>", when_loaded("cybu", function()
  require("cybu").cycle("next")
end), { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", when_loaded("cybu", function()
  require("cybu").cycle("prev")
end), { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bc", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("bprev")
  vim.api.nvim_buf_delete(bufnr, { force = true })
end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>n", ":enew<CR>", { desc = "New buffer" })

-- Theme picker
vim.keymap.set("n", "<leader>ft", when_loaded("nvchad.themes", function()
  require("nvchad.themes").open()
end), { desc = "Pick theme" })

-- Files
vim.keymap.set("n", "<leader>e", when_loaded("oil", function()
  require("oil").open(nil, { preview = { vertical = true } })
end), { desc = "Explore files" })
vim.keymap.set("n", "<leader>E", when_loaded("oil", function()
  require("oil").open(vim.fn.getcwd(), { preview = { vertical = true } })
end), { desc = "Explore cwd" })

-- Telescope shortcuts
vim.keymap.set("n", "<leader>ff", when_loaded("telescope", function()
  require("telescope.builtin").find_files()
end), { desc = "Find file" })

vim.keymap.set("n", "<leader>fg", when_loaded("telescope", function()
  require("telescope.builtin").live_grep()
end), { desc = "Live grep" })

vim.keymap.set("n", "<leader>bb", when_loaded("telescope", function()
  require("telescope.builtin").buffers()
end), { desc = "List buffers" })

vim.keymap.set("n", "<leader>gt", when_loaded("telescope", function()
  require("telescope.builtin").git_status()
end), { desc = "Git status" })

-- Git blame side window
vim.keymap.set("n", "<leader>gb", when_loaded("gitsigns", function()
  require("gitsigns").blame()
end), { desc = "Open blame" })

-- LSP keymaps, registered per-buffer on attach (see config/lsp.lua)
function M.lsp_maps(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "K", vim.lsp.buf.hover, "Hover doc")
  map("n", "<leader>lr", function()
    require("nvchad.lsp.renamer")()
  end, "Rename symbol")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>li", function()
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end, "Toggle inlay hints")
  map("n", "<leader>ls", function()
    require("telescope.builtin").lsp_document_symbols()
  end, "Document symbols")
  map("n", "<leader>lR", ":lsp restart<CR>", "Restart LSP")
  map("n", "<leader>lS", ":lsp enable<CR>", "Start LSP")
end

-- Formatting via conform; works with or without an attached LSP.
-- Registered buffer-locally so it never shows up in non-file buffers (e.g. oil).
local conform_format = function()
  utils.strip_trailing_whitespace()
  require("conform").format({ async = true, lsp_format = "fallback" })
end

local fmt_group = vim.api.nvim_create_augroup("FormatMaps", { clear = true })

local function set_format_maps()
  vim.keymap.set("n", "<leader>lf", conform_format, { buffer = 0, desc = "Format buffer" })
  vim.keymap.set("v", "<leader>lf", conform_format, { buffer = 0, desc = "Format selection" })
end

local function del_format_maps()
  pcall(vim.keymap.del, "n", "<leader>lf", { buffer = 0 })
  pcall(vim.keymap.del, "v", "<leader>lf", { buffer = 0 })
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = fmt_group,
  callback = function()
    local is_file = vim.bo.buftype == ""
      and vim.bo.filetype ~= "oil"
      and vim.api.nvim_buf_get_name(0) ~= ""
    local want = is_file and "on" or "off"
    if vim.b.format_maps_state == want then
      return
    end
    vim.b.format_maps_state = want
    if is_file then
      set_format_maps()
    else
      del_format_maps()
    end
  end,
})

-- Trouble
vim.keymap.set("n", "<leader>xx", cmd_when_loaded("trouble", "Trouble diagnostics toggle"), { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>xw", cmd_when_loaded("trouble", "Trouble diagnostics toggle filter.buf=0"), { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>xl", cmd_when_loaded("trouble", "Trouble loclist toggle"), { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", cmd_when_loaded("trouble", "Trouble qflist toggle"), { desc = "Quickfix list" })

-- Screenkey
vim.keymap.set("n", "<leader>st", when_loaded("screenkey", function()
  require("screenkey").toggle()
end), { desc = "Toggle screenkey" })

-- Obsidian
vim.keymap.set("n", "<leader>oo", cmd_when_loaded("obsidian", "Obsidian today"), { desc = "Today's daily note" })
vim.keymap.set("n", "<leader>os", cmd_when_loaded("obsidian", "Obsidian search"), { desc = "Search notes" })
vim.keymap.set("n", "<leader>oq", cmd_when_loaded("obsidian", "Obsidian quick_switch"), { desc = "Quick switch notes" })
vim.keymap.set("n", "<leader>ol", cmd_when_loaded("obsidian", "Obsidian open"), { desc = "Open note" })
vim.keymap.set("n", "<leader>od", cmd_when_loaded("obsidian", "Obsidian dailies"), { desc = "Dailies picker" })
vim.keymap.set("n", "<leader>on", cmd_when_loaded("obsidian", "Obsidian new"), { desc = "New note" })
vim.keymap.set("n", "<leader>ot", cmd_when_loaded("obsidian", "Obsidian tags"), { desc = "Tags picker" })
vim.keymap.set("n", "<leader>ob", cmd_when_loaded("obsidian", "Obsidian backlinks"), { desc = "Backlinks" })
vim.keymap.set("n", "<leader>o.", cmd_when_loaded("obsidian", "Obsidian follow_link"), { desc = "Follow link" })
vim.keymap.set("n", "<leader>o,", cmd_when_loaded("obsidian", "Obsidian toc"), { desc = "Table of contents" })
vim.keymap.set("n", "<leader>of", cmd_when_loaded("obsidian", "Obsidian footnotes"), { desc = "Footnotes" })
vim.keymap.set("n", "<leader>oi", cmd_when_loaded("obsidian", "Obsidian paste_img"), { desc = "Paste image" })
vim.keymap.set("n", "<leader>or", cmd_when_loaded("obsidian", "Obsidian rename"), { desc = "Rename note" })
vim.keymap.set("n", "<leader>ox", cmd_when_loaded("obsidian", "Obsidian toggle_checkbox"), { desc = "Toggle checkbox" })
vim.keymap.set("n", "<leader>otm", cmd_when_loaded("obsidian", "Obsidian template"), { desc = "Insert template" })
vim.keymap.set("n", "<leader>oun", cmd_when_loaded("obsidian", "Obsidian unique_note"), { desc = "New unique note" })
vim.keymap.set("n", "<leader>ouw", cmd_when_loaded("obsidian", "Obsidian workspace"), { desc = "Switch workspace" })
vim.keymap.set("v", "<leader>oe", cmd_when_loaded("obsidian", "Obsidian extract_note"), { desc = "Extract note" })
vim.keymap.set("v", "<leader>ol", cmd_when_loaded("obsidian", "Obsidian link"), { desc = "Link selection" })

-- Treesitter Textobjects
vim.keymap.set({ "x", "o" }, "af", when_loaded("nvim-treesitter-textobjects.select", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end), { desc = "Function outer" })

vim.keymap.set({ "x", "o" }, "if", when_loaded("nvim-treesitter-textobjects.select", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end), { desc = "Function inner" })

vim.keymap.set({ "x", "o" }, "ac", when_loaded("nvim-treesitter-textobjects.select", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end), { desc = "Class outer" })

vim.keymap.set({ "x", "o" }, "ic", when_loaded("nvim-treesitter-textobjects.select", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end), { desc = "Class inner" })

vim.keymap.set("n", "gs", when_loaded("nvim-treesitter-textobjects.swap", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end), { desc = "Swap next param" })

vim.keymap.set("n", "gS", when_loaded("nvim-treesitter-textobjects.swap", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end), { desc = "Swap prev param" })

return M
