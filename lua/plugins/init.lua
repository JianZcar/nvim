local add = MiniDeps.add

-- Explicit list so stray files in this directory are never auto-loaded.
local specs = {
  "core", "ui", "lsp", "autocomplete", "picker", "colorscheme",
  "file-manager", "obsidian", "opencode", "screenkey", "git",
}

for _, name in ipairs(specs) do
  for _, spec in ipairs(require("plugins." .. name)) do
    add(spec)
  end
end
