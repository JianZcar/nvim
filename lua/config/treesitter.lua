require 'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<C-Space>",  -- start selection
      node_incremental  = "<C-Space>",  -- expand selection
      node_decremental  = "<BS>",       -- shrink selection
      scope_incremental = false,      -- expand to scope
    },
  },
}

