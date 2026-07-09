require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    {
      name = "vault",
      path = "~/vault",
    },
  },
  daily_notes = {
    folder = "dailies/",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    default_tags = { "daily-notes" },
  },
})
