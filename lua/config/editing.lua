require("mini.surround").setup()
require("mini.comment").setup({
  options = {
    custom_commentstring = function()
      return require("ts_context_commentstring").calculate_commentstring()
          or vim.bo.commentstring
    end,
  },
})

-- Keymaps for treesitter selection live in core/keymaps.lua.

require("flash").setup({
  modes = {
    search = { enabled = false },
  },
})
