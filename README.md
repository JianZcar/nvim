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
- Treesitter syntax highlighting, indentation, and textobjects (javascript, typescript, html, css, styled, lua, python, bash, rust, go, c_sharp)
- LSP support via `mason.nvim` with 11 servers: `lua_ls`, `html`, `cssls`, `tailwindcss`, `unocss`, `ts_ls`, `pyright`, `omnisharp`, `bashls`, `rust_analyzer`, `gopls`
- Autocompletion with `blink.cmp` (`colorful-menu`, snippets, auto-brackets, doc preview)
- LSP features for code embedded in documents (activates `html`/`styled` in JS, TS, and React buffers) — `otter.nvim`
- Autopairs with treesitter integration

### UI
- NvChad unified UI (statusline, theme engine) – `ayu_light` theme, `vscode_colored` statusline
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
| `n` | `<leader>w` / `<leader>q` | Save / Quit |
| `n` | `<leader>W` / `<leader>Q` | Save all / Force quit all |
| `n` | `<leader>c` | Close buffer |
| `n` | `<leader>C` | Clear search highlights |
| `n` | `<leader>bc` | Close buffer (jump to previous) |
| `t` | `;;` | Escape terminal mode |
| `n` | `n` / `N` | Search next / prev (centered) |
| `n` | `<C-d>` / `<C-u>` | Half-page down / up (centered) |
| `n` | `<C-h/j/k/l>` | Window navigation |
| `n` | `<C-Up/Down>` / `<C-Left/Right>` | Resize height / width |
| `n` | `<Tab>` / `<S-Tab>` | Next / prev buffer (cybu) |
| `n` | `<leader>tn` / `<leader><Tab>` / `<leader><S-Tab>` | New / next / prev tab |
| `n` | `<leader>ft` | Pick theme |
| `n` | `<leader>e` / `<leader>E` | Oil (cwd or current) |
| `n` | `<leader>ff` / `<leader>fg` | Telescope find files / live grep |
| `n` | `<leader>bb` / `<leader>gt` | Telescope buffers / git status |
| `n` | `gd` / `gr` / `K` | LSP definition / references / hover |
| `n` | `<leader>la` / `<leader>lr` | LSP code action / rename |
| `n`/`v` | `<leader>lf` | Format buffer / selection |
| `n` | `<leader>xx` / `<leader>xw` | Trouble diagnostics (all / buffer) |
| `n` | `<leader>xl` / `<leader>xq` | Trouble loclist / quickfix |
| `n` | `<leader>st` | Toggle screenkey |
| `n` | `<C-Space>` / `<BS>` | Increment / decrement number |
| `n`/`x` | `<leader>oa` | Ask OpenCode (`@this`) |
| `n`/`x` | `<leader>op` | Select OpenCode prompt |
| `n`/`x` | `go` | Append range to OpenCode |
| `n` | `goo` | Append line to OpenCode |
| `n` | `<S-C-u>` / `<S-C-d>` | Scroll OpenCode session |
| `n` | `<leader>oo` / `<leader>os` | Obsidian today's note / search |
| `n` | `<leader>oq` / `<leader>ol` | Obsidian quick switch / open note |
| `n` | `<leader>od` / `<leader>on` | Obsidian dailies / new note |
| `n` | `<leader>ot` / `<leader>ob` | Obsidian tags / backlinks |
| `n` | `<leader>o.` / `<leader>o,` | Obsidian follow link / toc |
| `n` | `<leader>of` / `<leader>oi` | Obsidian footnotes / paste image |
| `n` | `<leader>or` / `<leader>ox` | Obsidian rename / toggle checkbox |
| `n` | `<leader>otm` / `<leader>oun` | Obsidian template / unique note |
| `n` | `<leader>ouw` | Obsidian switch workspace |
| `v` | `<leader>oe` / `<leader>ol` | Obsidian extract / link selection |
| `x`/`o` | `af` / `if` / `ac` / `ic` | Treesitter textobjects (function/class) |
| `n` | `<leader>a` / `<leader>A` | Swap next / prev parameter |
| `x` | `J` / `K` | Move lines down / up |

---

## Install

> I recommend forking the repo to make it your own.

1. Clone the repo:

    ```bash
    git clone https://github.com/JianZcar/nvim.git ~/.config/nvim
    ```

2. Open Neovim — plugins will install automatically.
