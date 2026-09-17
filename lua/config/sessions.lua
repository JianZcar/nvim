require("mini.sessions").setup({
  autoread = false, -- don't auto-restore a session on bare nvim
  autowrite = true,
  file = "",        -- disable local Session.vim files (global sessions only)
})
