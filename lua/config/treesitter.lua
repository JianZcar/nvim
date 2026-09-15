local parsers = {
  "javascript", "typescript", "html", "css", "styled",
  "lua", "python", "bash", "rust", "go", "c_sharp",
}

require("nvim-treesitter").install(parsers)

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = "v", -- charwise
      ['@function.outer'] = "V",  -- linewise
      ['@class.outer'] = "<c-v>", -- blockwise
    },
    include_surrounding_whitespace = false,
  },
}

-- As a substitute to treesitter incremental
require('incr').setup({
  incr_key = "<C-Space>", -- Ctrl+Space
  decr_key = "<BS>",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok = pcall(vim.treesitter.language.add, vim.bo[args.buf].filetype)
    if ok then
      pcall(vim.treesitter.start, args.buf, vim.bo[args.buf].filetype, { injections = true })
    end
  end,
})
