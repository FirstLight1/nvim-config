# Keymaps

Leader key is **Space** (`<leader>` = `<Space>`).

## Core (`lua/firstlight/remap.lua`)

| Keys         | Mode | Action                                                        |
| ------------ | ---- | ------------------------------------------------------------- |
| `<leader>pv` | n    | Open netrw file explorer (`:Ex`)                              |
| `<leader>cg` | n    | Run `claude -p` on `git diff HEAD`, show review in a float    |
| `q`          | n    | Close the Claude review float (buffer-local, inside that win) |

## Claude Code (`lua/firstlight/lazy.lua`)

| Keys         | Mode | Action                                                 |
| ------------ | ---- | ------------------------------------------------------ |
| `<leader>c`  | n    | (which-key group label "AI/Claude", no action)         |
| `<leader>cc` | n    | Toggle the Claude terminal (`:ClaudeCode`)             |
| `<leader>cf` | n    | Focus the Claude window                                |
| `<leader>cr` | n    | Open Claude resuming a past session (`--resume`)       |
| `<leader>cC` | n    | Continue the most recent session (`--continue`)        |
| `<leader>cb` | n    | Add the current buffer to Claude's context             |
| `<leader>cs` | v    | Send the visual selection to Claude                    |
| `<leader>cs` | n    | Add file from tree (NvimTree/neo-tree/oil/minifiles)   |
| `<leader>ca` | n    | Accept the proposed diff                               |
| `<leader>cd` | n    | Deny the proposed diff                                 |

## Harpoon (`after/plugin/harpoon.lua`)

| Keys        | Mode | Action                          |
| ----------- | ---- | ------------------------------- |
| `<leader>a` | n    | Add current file to Harpoon list |
| `<C-e>`     | n    | Toggle the Harpoon quick-menu   |
| `<C-h>`     | n    | Jump to Harpoon file 1          |
| `<C-t>`     | n    | Jump to Harpoon file 2          |
| `<C-n>`     | n    | Jump to Harpoon file 3          |
| `<C-s>`     | n    | Jump to Harpoon file 4          |

## Telescope (`after/plugin/telescope.lua`)

| Keys         | Mode | Action                                   |
| ------------ | ---- | ---------------------------------------- |
| `<leader>pf` | n    | Find files (fuzzy)                       |
| `<C-p>`      | n    | Find git-tracked files                   |
| `<leader>ps` | n    | Prompt for a string, then grep the project |

## LSP (`after/plugin/lsp.lua`, buffer-local when an LSP attaches)

| Keys          | Mode | Action                  |
| ------------- | ---- | ----------------------- |
| `gd`          | n    | Go to definition        |
| `K`           | n    | Hover docs              |
| `<leader>vws` | n    | Workspace symbol search |
| `<leader>vd`  | n    | Open diagnostic float   |
| `[d`          | n    | Next diagnostic         |
| `]d`          | n    | Previous diagnostic     |
| `<leader>vca` | n    | Code action             |
| `<leader>vrr` | n    | List references         |
| `<leader>vrn` | n    | Rename symbol           |
| `<C-h>`       | i    | Signature help          |

## Git / Undo

| Keys         | Mode | Action                          | File             |
| ------------ | ---- | ------------------------------- | ---------------- |
| `<leader>gs` | n    | Open Fugitive git status (`:Git`) | `fugitive.lua`   |
| `<leader>u`  | n    | Toggle Undotree                 | `undutree.lua`   |
