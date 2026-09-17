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

vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<Cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<Cmd>qa!<CR>", { desc = "Force quit all" })
vim.keymap.set("n", "<leader>W", "<Cmd>wa<CR>", { desc = "Save all" })
vim.keymap.set("n", "<leader>c", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].modified then
    vim.notify("Buffer has unsaved changes, not closing", vim.log.levels.WARN)
    return
  end
  local ok_prev = pcall(vim.cmd, "bprevious")
  if not ok_prev then
    pcall(vim.cmd, "enew")
  end
  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_delete(bufnr, {})
  end
end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>C", "<Cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Centered navigation
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Folding
vim.keymap.set("n", "<leader>z", "za", { desc = "Toggle fold" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Create windows / buffers
vim.keymap.set("n", "<leader>h", "<Cmd>split<CR>", { desc = "New horizontal window" })
vim.keymap.set("n", "<leader>v", "<Cmd>vsplit<CR>", { desc = "New vertical window" })

-- Buffers
vim.keymap.set("n", "<Tab>", when_loaded("cybu", function()
  require("cybu").cycle("next")
end), { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", when_loaded("cybu", function()
  require("cybu").cycle("prev")
end), { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>n", "<Cmd>enew<CR>", { desc = "New buffer" })

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

vim.keymap.set("n", "<leader>b", when_loaded("telescope", function()
  require("telescope.builtin").buffers()
end), { desc = "List buffers" })

vim.keymap.set("n", "<leader>gt", when_loaded("telescope", function()
  require("telescope.builtin").git_status()
end), { desc = "Git status" })

vim.keymap.set("n", "<leader>fr", when_loaded("grug-far", function()
  require("grug-far").open()
end), { desc = "Find & replace" })

-- Git blame side window
vim.keymap.set("n", "<leader>gb", when_loaded("gitsigns", function()
  require("gitsigns").blame()
end), { desc = "Open blame" })

-- Calling the Lua function directly is more robust than :LazyGit: it works
-- regardless of whether the plugin script has been sourced.
vim.keymap.set("n", "<leader>gg", when_loaded("lazygit", function()
  require("lazygit").lazygit()
end), { desc = "Open lazygit" })

-- LSP keymaps, registered per-buffer on attach (see config/lsp.lua)
function M.lsp_maps(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "K", vim.lsp.buf.hover, "Hover doc")
  map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, "Next diagnostic")
  map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, "Prev diagnostic")
  map("n", "gl", vim.diagnostic.open_float, "Show line diagnostics")
  map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "<leader>lr", function()
    require("nvchad.lsp.renamer")()
  end, "Rename symbol")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>li", function()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  end, "Toggle inlay hints")
  map("n", "<leader>ls", function()
    require("telescope.builtin").lsp_document_symbols()
  end, "Document symbols")
  map("n", "<leader>lR", "<Cmd>lsp restart<CR>", "Restart LSP")
  map("n", "<leader>lS", "<Cmd>lsp enable<CR>", "Start LSP")
end

-- Formatting via conform; works with or without an attached LSP.
-- Registered buffer-locally so it never shows up in non-file buffers (e.g. oil).
local conform_format = function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end

local fmt_group = vim.api.nvim_create_augroup("FormatMaps", { clear = true })

local function set_format_maps(bufnr)
  vim.keymap.set("n", "<leader>lf", conform_format, { buffer = bufnr, desc = "Format buffer" })
  vim.keymap.set("v", "<leader>lf", conform_format, { buffer = bufnr, desc = "Format selection" })
end

local function del_format_maps(bufnr)
  pcall(vim.keymap.del, "n", "<leader>lf", { buffer = bufnr })
  pcall(vim.keymap.del, "v", "<leader>lf", { buffer = bufnr })
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = fmt_group,
  callback = function(args)
    local bufnr = args.buf
    local is_file = vim.bo[bufnr].buftype == ""
        and vim.bo[bufnr].filetype ~= "oil"
        and vim.api.nvim_buf_get_name(bufnr) ~= ""
    local want = is_file and "on" or "off"
    if vim.b[bufnr].format_maps_state == want then
      return
    end
    vim.b[bufnr].format_maps_state = want
    if is_file then
      set_format_maps(bufnr)
    else
      del_format_maps(bufnr)
    end
  end,
})

-- Lint suggestions (nvim-lint; see :LintDisable/:LintEnable in config/lsp.lua)
vim.keymap.set("n", "<leader>ll", function()
  vim.g.disable_lint = not vim.g.disable_lint
  if vim.g.disable_lint then
    utils.clear_lint_diagnostics()
  else
    pcall(require("lint").try_lint)
  end
  vim.notify("Lint suggestions " .. (vim.g.disable_lint and "off" or "on"), vim.log.levels.INFO)
end, { desc = "Toggle lint suggestions" })

-- Trouble
vim.keymap.set("n", "<leader>xx", cmd_when_loaded("trouble", "Trouble diagnostics toggle"),
  { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>xw", cmd_when_loaded("trouble", "Trouble diagnostics toggle filter.buf=0"),
  { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>xl", cmd_when_loaded("trouble", "Trouble loclist toggle"), { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", cmd_when_loaded("trouble", "Trouble qflist toggle"), { desc = "Quickfix list" })

-- Screenkey
vim.keymap.set("n", "<leader>st", when_loaded("screenkey", function()
  require("screenkey").toggle()
end), { desc = "Toggle screenkey" })

-- Sessions (mini.sessions)
vim.keymap.set("n", "<leader>ss", when_loaded("mini.sessions", function()
  vim.ui.input({ prompt = "Session name: " }, function(name)
    if name and name ~= "" then
      require("mini.sessions").write(name)
    end
  end)
end), { desc = "Save session" })

vim.keymap.set("n", "<leader>sr", when_loaded("mini.sessions", function()
  require("mini.sessions").select("read")
end), { desc = "Restore session" })

vim.keymap.set("n", "<leader>sd", when_loaded("mini.sessions", function()
  require("mini.sessions").select("delete")
end), { desc = "Delete session" })

vim.keymap.set("n", "<leader>sl", when_loaded("mini.sessions", function()
  require("mini.sessions").read()
end), { desc = "Restore latest session" })

-- OpenCode
vim.keymap.set({ "n", "x" }, "<leader>oa", when_loaded("opencode", function()
  require("opencode").ask("@this: ")
end), { desc = "Ask OpenCode" })

vim.keymap.set({ "n", "x" }, "<leader>op", when_loaded("opencode", function()
  require("opencode").select()
end), { desc = "Select OpenCode" })

vim.keymap.set({ "n", "x" }, "go", when_loaded("opencode", function()
  return require("opencode").operator("@this ")
end), { desc = "Append range to OpenCode", expr = true })

vim.keymap.set("n", "goo", when_loaded("opencode", function()
  return require("opencode").operator("@this ") .. "_"
end), { desc = "Append line to OpenCode", expr = true })

vim.keymap.set("n", "<S-C-u>", when_loaded("opencode", function()
  require("opencode").command("session.half.page.up")
end), { desc = "Scroll OpenCode up" })

vim.keymap.set("n", "<S-C-d>", when_loaded("opencode", function()
  require("opencode").command("session.half.page.down")
end), { desc = "Scroll OpenCode down" })

-- Obsidian
vim.keymap.set("n", "<leader>oo", cmd_when_loaded("obsidian", "Obsidian today"), { desc = "Today's daily note" })
vim.keymap.set("n", "<leader>os", cmd_when_loaded("obsidian", "Obsidian search"), { desc = "Search notes" })
vim.keymap.set("n", "<leader>oq", cmd_when_loaded("obsidian", "Obsidian quick_switch"), { desc = "Quick switch notes" })
vim.keymap.set("n", "<leader>ol", cmd_when_loaded("obsidian", "Obsidian open"), { desc = "Open note" })
vim.keymap.set("n", "<leader>od", cmd_when_loaded("obsidian", "Obsidian dailies"), { desc = "Dailies picker" })
vim.keymap.set("n", "<leader>on", cmd_when_loaded("obsidian", "Obsidian new"), { desc = "New note" })
vim.keymap.set("n", "<leader>oT", cmd_when_loaded("obsidian", "Obsidian tags"), { desc = "Tags picker" })
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

-- Flash navigation
vim.keymap.set({ "n", "x", "o" }, "s", when_loaded("flash", function()
  require("flash").jump()
end), { desc = "Flash jump" })

vim.keymap.set({ "n", "x", "o" }, "S", when_loaded("flash", function()
  require("flash").treesitter()
end), { desc = "Flash treesitter select" })

vim.keymap.set("n", "<C-Space>", function()
  vim.api.nvim_feedkeys("van", "mx", true)
end, { desc = "Select parent node" })
vim.keymap.set("x", "<C-Space>", function()
  vim.api.nvim_feedkeys("an", "mx", true)
end, { desc = "Expand selection to parent node" })
vim.keymap.set("x", "<BS>", function()
  vim.api.nvim_feedkeys("in", "mx", true)
end, { desc = "Shrink selection to child node" })

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
