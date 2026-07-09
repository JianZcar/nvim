# Neovim Config

This is my personal Neovim setup. It's designed to be **fast**, **lightweight**, and **easy to hack on**. The goal is to keep only what I actually use, while still having modern features like autocompletion, treesitter, LSP, and a unified UI.

I use **`nvchad/ui`** for a consistent interface and **`mini.deps`** for plugin management. This combination keeps things simple and avoids the complexity of heavier frameworks, while still giving me full control over my config.

---

## Why This Setup?

- **Fast** – Minimal plugin loader (`mini.deps`) means startup is nearly instant.
- **Modular** – Three-layer architecture: `core/` (base config), `plugins/` (specs), `config/` (setup).
- **Unified UI** – `nvchad/ui` provides a consistent statusline, theme engine, and components.
- **Practical** – Includes LSP, completion, autopairs, git integration, fuzzy finding, file management, markdown notes, and more.

---

## Config Layout

- **`lua/core/`** – Base Neovim setup (options, keymaps, autocmds, utils, bootstrap)
- **`lua/plugins/`** – Plugin specs organized by purpose, auto-loaded via `mini.deps`
- **`lua/config/`** – Plugin configurations (LSP, UI, autocomplete, treesitter, etc.)
- **`lua/chadrc.lua`** – NvChad UI overrides (theme, statusline, component toggles)

---

## Features

### Core
- Treesitter syntax highlighting, indentation, and textobject selection
- LSP support via `mason.nvim` with 10 servers: `lua_ls`, `html`, `cssls`, `tailwindcss`, `ts_ls`, `pyright`, `omnisharp`, `bashls`, `rust_analyzer`, `gopls`
- Autocompletion with `blink.cmp` (color-enhanced menu, snippets)
- Autopairs with treesitter integration

### UI
- NvChad unified UI (statusline, theme engine) – `ayu_light` theme
- Indentation guides (`indent-blankline.nvim`)
- Context-aware buffer navigation with preview (`cybu.nvim`)
- Which-key popup for keybinding discovery
- Git signs with inline blame (`gitsigns.nvim`)
- LSP progress spinner (`fidget.nvim`)
- Screenkey display for screencasts (`screenkey.nvim`)

### Navigation & Editing
- Telescope fuzzy finder (files, grep, buffers, git status, LSP symbols)
- Oil.nvim file explorer (editor-based, with git status, delete-to-trash)
- Increment/decrement numbers (`incr.nvim`)
- Prevent nested Neovim instances (`unception.nvim`)
- Markdown preview rendering (`markview.nvim`)
- Trouble diagnostics viewer

### Obsidian Integration
- Full vault integration (daily notes, search, quick switch, backlinks, tags)
- Paste images, footnotes, templates, checkboxes
- Link and extract notes from visual selections
- Workspace switching

### AI Assistant
- Connect to any OpenCode server, or start an integrated instance
- Inject editor context (cursor, selection, buffer, etc.) into prompts
- Select from built-in and custom prompts
- Execute OpenCode commands directly
- Accept/reject and preview OpenCode edits via diff
- Operator mappings for seamless range-based interaction

### Key Mappings

| Mode | Key | Action |
|---|---|---|
| `n` | `<leader>ff` | Telescope find files |
| `n` | `<leader>fg` | Telescope live grep |
| `n` | `<leader>bb` | Telescope buffers |
| `n` | `<leader>gt` | Telescope git status |
| `n` | `<leader>e` / `<leader>E` | Oil (cwd or current) |
| `n` | `gd` | LSP definition |
| `n` | `gr` | LSP references |
| `n` | `K` | LSP hover |
| `n` | `<leader>la` | LSP code action |
| `n` | `<leader>lr` | LSP rename |
| `n` | `<leader>lf` | Format buffer |
| `n` | `<leader>xx` / `<leader>xw` | Trouble diagnostics |
| `n` | `<leader>oo`–`<leader>ouw` | Obsidian commands |
| `n`/`x` | `<leader>oa` | Ask OpenCode |
| `n`/`x` | `<leader>op` | Select OpenCode |
| `n`/`x` | `go` | Append range to OpenCode |
| `n` | `goo` | Append line to OpenCode |
| `n` | `<leader>st` | Toggle screenkey |
| `n` | `<Tab>` / `<S-Tab>` | Buffer navigation (cybu) |
| `n` | `<C-h/j/k/l>` | Window navigation |
| `x` | `J` / `K` | Move lines up/down |
| `x/o` | `af` / `if` / `ac` / `ic` | Treesitter textobjects |

---

## Install

> I recommend forking the repo to make it your own.

1. Clone the repo:

```bash
git clone https://github.com/JianZcar/nvim.git ~/.config/nvim
```

2. Open Neovim — plugins will install automatically.
