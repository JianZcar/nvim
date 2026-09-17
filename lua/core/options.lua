-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(vim.opt.undodir:get()[1], "p")
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
-- Non-zero so <M-..> mappings still work
vim.opt.ttimeoutlen = 10
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior settings
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

vim.opt.guicursor = {
  "n:block-Cursor",
  "v:block-Cursor",
  "i:ver25-Cursor/lCursor",
  "r:hor20-Cursor/lCursor",
  "c:block-Cursor/lCursor",
  "o:hor50-Cursor/lCursor",
  "a:blinkwait250-blinkoff250-blinkon250",
}

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldlevelstart = 99

-- Disable netrw; oil.nvim owns file browsing
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
