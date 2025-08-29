vim.opt.shortmess:append("I") -- disables nvim intro

local colorscheme = "catppuccin"
local colorscheme_setup = {
  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = { light = "latte", dark = "frappe" },
  transparent_background = false,
  float = { transparent = false, solid = false },
  auto_integrations = true,
}

require("gitsigns").setup({
  current_line_blame = true,
})

local cmp = {
  cmdline = {
    enabled = false,
  },
  keymap = {
    preset = "default", -- uses sensible defaults
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    trigger = {
      show_on_keyword = true,
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
    },
    documentation = {
      auto_show = true,
      window = {
        winblend = 10,
      },
    },
    menu = {
      winblend = 10,
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    list = {
      selection = { preselect = false },
    },
  },
}

require("catppuccin").setup(colorscheme_setup)
vim.cmd.colorscheme(colorscheme)

require('lualine').setup {}
require("colorful-menu").setup()
require("blink.cmp").setup(cmp)
