local M = {}

function M.pick_buffers_filtered(opts)
  opts = opts or {}

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  local vimgrep_previewer = previewers.vim_buffer_vimgrep.new({})

  local results = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(bufnr) == 1 then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name and name ~= "" then
        table.insert(results, {
          display = vim.fn.fnamemodify(name, ":."),
          value = name,
          bufnr = bufnr,
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
          value = entry.value,
          display = entry.display,
          ordinal = entry.display,
          bufnr = entry.bufnr,
          filename = entry.value,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    previewer = vimgrep_previewer,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        if not entry then
          return
        end
        actions.close(prompt_bufnr)
        vim.api.nvim_set_current_buf(entry.bufnr)
      end)
      return true
    end,
  }):find()
end

return M