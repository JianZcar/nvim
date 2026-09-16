local installs = {
  "javascript", "typescript", "tsx", "html", "css", "styled",
  "lua", "python", "bash", "rust", "go", "c_sharp",
}

require("nvim-treesitter").install(installs)

-- filetype -> parser for the FileType autocmd; omitted fts fall back to ft == parser
local auto_start = {
  typescriptreact = "tsx",
  javascriptreact = "javascript",
}

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v", -- charwise
      ["@function.outer"] = "V",  -- linewise
      ["@class.outer"] = "<c-v>", -- blockwise
    },
    include_surrounding_whitespace = false,
  },
}

-- As a substitute to treesitter incremental
require("incr").setup({
  incr_key = "<C-Space>", -- Ctrl+Space
  decr_key = "<BS>",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = auto_start[ft]
    if lang == nil and not vim.tbl_contains(installs, ft) then
      return
    end
    lang = lang or ft
    vim.treesitter.language.register(lang, ft)
    local ok_start, err_start = pcall(vim.treesitter.start, args.buf, lang)
    if not ok_start then
      vim.notify("Failed to start treesitter for " .. ft .. ": " .. tostring(err_start), vim.log.levels.WARN)
    end
  end,
})

require("mini.surround").setup()
require("mini.comment").setup()
