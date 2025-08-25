return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local previewers = require("telescope.previewers")

      -- Use the vimgrep-style previewer (vim_buffer_vimgrep)
      local vimgrep_previewer = previewers.vim_buffer_vimgrep.new({})

      -- Custom buffer picker that excludes unlisted and [No Name] buffers + vimgrep preview
      local function pick_buffers_filtered(opts)
        opts = opts or {}

        local results = {}
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.fn.buflisted(bufnr) == 1 then
            local name = vim.api.nvim_buf_get_name(bufnr)
            if name and name ~= "" then
              table.insert(results, {
                display = vim.fn.fnamemodify(name, ":."), -- relative path for display
                value   = name,                             -- absolute path (used for preview)
                bufnr   = bufnr,
              })
            end
          end
        end

        pickers.new(opts, {
          prompt_title = "Find Buffers",
          finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
              return {
                value   = entry.value,       -- used by actions
                display = entry.display,     -- shown in the list
                ordinal = entry.display,
                bufnr   = entry.bufnr,
                filename = entry.value,
                -- lnum = 1,
                -- col  = 1,
              }
            end,
          }),
          sorter = conf.generic_sorter(opts),
          previewer = vimgrep_previewer, -- <-- use vimgrep previewer here
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              local entry = action_state.get_selected_entry()
              if not entry then return end
              actions.close(prompt_bufnr)
              vim.api.nvim_set_current_buf(entry.bufnr)
            end)
            return true
          end,
        }):find()
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>bf", pick_buffers_filtered, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>ef", require("telescope.builtin").find_files, { desc = "Find files" })

      vim.keymap.set("n", "<leader>sc", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "Search in current buffer" })
      vim.keymap.set("n", "<leader>sb", function()
        require("telescope.builtin").live_grep({ grep_open_files = true })
      end, { desc = "Search in all buffers" })

      vim.keymap.set("n", "<leader>sf", require("telescope.builtin").live_grep, { desc = "Search in all files" })

    end,
  },
}
