return {
  -- Lua utilities
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
      }
    }
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = { "", "" },
          component_separators = { "|", "|" },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,  -- only install the parser for the current buffer if missing
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,         -- enable scope guides
        show_start = true,      -- underline start of scope
        show_end = true,       -- underline end of scope
        injected_languages = true, -- support TS injected langs
        highlight = { "Function", "Label" }, -- highlight groups for scope
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,         -- enable by default
        max_lines = 0,         -- max number of context lines shown
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",       -- show context based on cursor location ("cursor" or "topline")
        separator = "─",       -- line shown under context for separation
      })
    end,
  },

  -- Completion engine
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init({
        -- optional settings
        mode = "symbol_text", -- show symbol + text
        preset = "default",   -- can use codicons or default symbols
      })
    end,
  },

  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
        require("colorful-menu").setup({})
    end,
  },

  {
    "Saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = "default", -- uses sensible defaults
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          border = "rounded",
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
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
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",    -- like lspkind symbols
      },
      signature = { enabled = true },
    },
  opts_extend = { "sources.default" }
  }
}
