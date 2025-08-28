local actions = require("telescope.actions")
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {},
      pickers = {
        find_files = {
          layout_strategy = "vertical",
          layout_config = {
            width = 72,
            height = 40,
            prompt_position = "bottom",
          },
          border = true,
          attach_mappings = function(_, map)
            local function close_oil_then_select(prompt_bufnr)
              -- Close Oil windows first
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == "oil" then
                  vim.api.nvim_win_close(win, true)
                end
              end
              -- Then continue Telescope’s default selection behavior
              actions.select_default(prompt_bufnr)
            end

            map("i", "<CR>", close_oil_then_select)
            map("n", "<CR>", close_oil_then_select)
            return true
          end,
        },
        buffers = {
          layout_strategy = "vertical",
          layout_config = {
            width = 72,
            height = 40,
            prompt_position = "bottom",
          },
          border = true,
          attach_mappings = function(_, map)
            local function close_oil_then_select(prompt_bufnr)
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == "oil" then
                  vim.api.nvim_win_close(win, true)
                end
              end
              actions.select_default(prompt_bufnr)
            end

            map("i", "<CR>", close_oil_then_select)
            map("n", "<CR>", close_oil_then_select)
            return true
          end,
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },
}
