local installs = {
  "javascript", "typescript", "tsx", "html", "css", "styled",
  "lua", "python", "bash", "rust", "go", "c_sharp",
  "json", "yaml", "toml", "markdown", "markdown_inline",
  "dockerfile", "vim", "vimdoc",
}

-- Parsers are installed via :TSUpdate (see plugins/editing.lua post_checkout)
-- plus this no-op-if-installed call for fresh clones.
require("nvim-treesitter").install(installs)

-- filetype -> parser; omitted fts fall back to ft == parser
local auto_start = {
  typescriptreact = "tsx",
  javascriptreact = "javascript",
}

local install_set = {}
for _, lang in ipairs(installs) do
  install_set[lang] = true
end
for _, lang in pairs(auto_start) do
  install_set[lang] = true
end

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = false,
  },
}

local ts_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    local lang = auto_start[ft] or vim.treesitter.language.get_lang(ft)
    if not lang or not install_set[lang] then
      return
    end
    -- Skip if parser is not installed yet (install runs async on fresh clones).
    if not pcall(vim.treesitter.language.add, lang) then
      return
    end
    pcall(vim.treesitter.start, bufnr, lang)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({
  enable_autocmd = false,
})

require("nvim-ts-autotag").setup()
