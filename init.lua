require("core.options")
require("core.lazy")
require("core.keymaps")

vim.opt.shortmess:append("I")
vim.opt.fillchars:append({ eob = " " })

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })

vim.diagnostic.config({
  virtual_text = true,   -- show inline diagnostics
  signs = false,          -- show signs in the gutter
  update_in_insert = false,
})

-- require("core.autocmds")

