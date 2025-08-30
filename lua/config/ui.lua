vim.opt.shortmess:append("I") -- disables nvim intro

local colorscheme = "onenord"
local colorscheme_setup = {
  theme = "light", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  borders = true, -- Split window borders
  fade_nc = false, -- Fade non-current windows, making them more distinguishable
  -- Style that is applied to various groups: see `highlight-args` for options
  styles = {
    comments    = "italic",
    strings     = "NONE",
    keywords    = "bold,italic",
    functions   = "bold",
    variables   = "NONE",
    diagnostics = "undercurl",
  },
  disable = {
    background = false, -- Disable setting the background color
    float_background = false, -- Disable setting the background color for floating windows
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  -- Inverse highlight for different groups
  inverse = {
    match_paren = false,
  },
  custom_highlights = {}, -- Overwrite default highlight groups
  custom_colors = {}, -- Overwrite default colors
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

require("onenord").setup(colorscheme_setup)
vim.cmd.colorscheme(colorscheme)

require('lualine').setup {}
require("colorful-menu").setup()
require("blink.cmp").setup(cmp)
