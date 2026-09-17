local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function delete_selected(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  if not picker then
    return
  end
  local multi = picker:get_multi_selection()
  if vim.tbl_isempty(multi) then
    local s = action_state.get_selected_entry()
    if s and s.bufnr and vim.api.nvim_buf_is_valid(s.bufnr) then
      vim.api.nvim_buf_delete(s.bufnr, { force = false })
    else
      vim.notify("No valid buffer selected", vim.log.levels.WARN)
      return
    end
  else
    for _, e in ipairs(multi) do
      if e.bufnr and vim.api.nvim_buf_is_valid(e.bufnr) then
        vim.api.nvim_buf_delete(e.bufnr, { force = false })
      end
    end
  end
  actions.close(prompt_bufnr)
end

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 40,
    },
    file_ignore_patterns = { ".git/", "node_modules/", "%.lock" },
  },
  pickers = {
    find_files = {
      hidden = true
    },
    buffers = {
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-d>", function() delete_selected(prompt_bufnr) end)
        map("n", "<C-d>", function() delete_selected(prompt_bufnr) end)
        return true
      end,
    },
  },
  extensions = {
    ["ui-select"] = {},
  }
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

require("grug-far").setup()

-- Keymap (<leader>fr) lives in core/keymaps.lua.