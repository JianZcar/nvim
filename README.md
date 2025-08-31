# Neovim Config

This is my personal Neovim setup. It’s designed to be **fast**, **lightweight**, and **easy to hack on**. The idea is to keep only what I actually use, while still having modern quality-of-life features like autocompletion, treesitter, and a unified UI.

I use **[`nvchad/ui`](https://github.com/NvChad/ui)** for a consistent, minimal interface and **[`mini.deps`](https://github.com/nvim-mini/mini.deps)** for plugin management. This combination keeps things clean and avoids the complexity of heavier frameworks like LazyVim or NvChad itself, while still giving me full control over my config.

---

## Why This Setup?

* **🚀 Fast** – Minimal plugin loader (`mini.deps`) means startup is almost instant, even on weaker machines.
* **🧩 Modular** – Plugins are split into clear categories. Configs live in their own files, so it’s easy to replace or remove anything.
* **🎨 Unified UI** – `nvchad/ui` makes the look and feel consistent across components like statusline, tabline, and telescope.
* **🛠️ Practical** – Includes all the essentials: LSP, completion, autopairs, commenting, git integration, fuzzy finding, etc. But nothing bloated.

---

## Config Layout

* **`lua/core/`** → Base Neovim setup (options, keymaps, autocmds).
* **`lua/plugins/`** → Plugin specs, organized by purpose (UI, LSP, editing, tools). Loaded with `mini.deps`.
* **`lua/config/`** → Plugin configurations (e.g. `lsp.lua`, `ui.lua`, `git.lua`).

This separation makes it **easy to maintain**: plugin installation stays minimal, while configs are neatly modular.

---

## Features at a Glance

✅ Treesitter syntax highlighting & indentation
✅ Intuitive File Management via Oil.nvim
✅ LSP with autocompletion (via `blink.cmp`)
✅ Autopairs, commenting, surround editing
✅ Telescope fuzzy finder with custom mappings
✅ Git integration (signs, diffs, statusline info)
✅ Unified UI via `nvchad/ui`
✅ Fast startup thanks to `mini.deps`

---

## Install

1. Clone the repo:

   ```bash
   git clone https://github.com/JianZcar/nvim-setup.git ~/.config/nvim
   ```

2. Open Neovim — plugins will install automatically.

---
