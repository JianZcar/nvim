local nvchad_blink = require("nvchad.blink.config")
local blink = {
  cmdline = {
    enabled = false,
  },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<CR>"] = { "accept", "fallback" }
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = {
      auto_show = true,
    },
    menu = {
      draw = {
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
    list = { selection = { preselect = false } },
  },
}

local autopairs = {
  check_ts = true,
  fast_wrap = {},
}

for k, v in pairs(nvchad_blink) do
  if type(v) == "table" and type(blink[k]) == "table" then
    blink[k] = vim.tbl_deep_extend("force", v, blink[k])
  elseif blink[k] == nil then
    blink[k] = v
  end
end

require("colorful-menu").setup()
require("blink.cmp").setup(blink)
require("nvim-autopairs").setup(autopairs)
