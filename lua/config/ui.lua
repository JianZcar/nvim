local indent = {
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
    injected_languages = true,
    highlight = { "Function", "Label" },
  },
}

local cybu = {
  position = {
    anchor = "center",
    vertical_offset = 0,
    horizontal_offset = 0,
  },
  style = {
    path = "relative",
    path_abbreviation = "none",
    border = "single",
    separator = " ",
    prefix = "…",
    padding = 1,
    hide_buffer_id = true,
    devicons = {
      enabled = true,
      colored = true,
      truncate = true,
    },
    highlights = {
      current_buffer = "TelescopeSelection",
      adjacent_buffers = "TelescopeNormal",
      background = "TelescopeNormal",
      border = "TelescopeBorder",
    },
  }
}

require("markview").setup({
  experimental = {
    check_rtp_message = false
  }
})

local fidget = {
  notification = { override_vim_notify = false }
}

require("base46").load_all_highlights()
require("nvchad")

require("cybu").setup(cybu)
require("fidget").setup(fidget)
require("ibl").setup(indent)
