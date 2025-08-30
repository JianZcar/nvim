require("gitsigns").setup({
  current_line_blame = true,
})

local nvchad_blink = require("nvchad.blink.config")
local blink = {
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

local telescope = {
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
            width = 70,
            height = 40,
            prompt_position = "top",
          },
  },
}

require("base46").load_all_highlights()
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end
require("nvchad")

for k,v in pairs(nvchad_blink) do
  if blink[k] == nil then
    blink[k] = v
  end
end

require("colorful-menu").setup()
require("blink.cmp").setup(blink)
require("telescope").setup(telescope)
