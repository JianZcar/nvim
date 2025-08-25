return {
	{
	  "Shatur/neovim-ayu",
	  lazy = false,
	  config = function()
	    require('ayu').setup({
	      mirage = false,  -- Use light variant
	      terminal = true, -- Let terminal manage its own colors
	      overrides = {
		Normal       = { bg = "None" },
		NormalFloat  = { bg = "None" },
		ColorColumn  = { bg = "None" },
		SignColumn   = { bg = "None" },
		Folded       = { bg = "None" },
		FoldColumn   = { bg = "None" },
		CursorLine   = { bg = "None" },
		CursorColumn = { bg = "None" },
		VertSplit    = { bg = "None" },
	      },
	    })

	    -- Apply the light variant explicitly
	    vim.cmd("colorscheme ayu-light")
	  end,
	}
}

