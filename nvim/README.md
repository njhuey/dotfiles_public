# nvim

Personal Neovim config. Plugin management via `vim.pack` (Neovim 0.12+).

## Install

```sh
./scripts/install.sh   # symlinks this repo to ~/.config/nvim
```

First launch will fetch plugins. Then run these once:

```vim
:MasonEnsure   " install LSP servers / formatters listed in lua/plugins/lsp.lua
:TSEnsure      " install treesitter parsers listed in lua/plugins/treesitter.lua
```

Both are intentionally manual — see Security below.

## Layout

```
init.lua                   entry point
lua/config/
  options.lua              vim.opt and vim.g
  plugins.lua              vim.pack.add() — the plugin list lives here
  keymaps.lua              global keymaps (LSP keymaps are in plugins/lsp.lua)
  autocmds.lua             filetype indent/colorcolumn rules
lua/plugins/
  colorscheme.lua          catppuccin
  completion.lua           blink.cmp
  lsp.lua                  mason + lspconfig + LspAttach keymaps + format-on-save
  treesitter.lua           parser install + filetype activation
  ui.lua                   snacks + bufferline
  utils.lua                fzf-lua + mini.pairs + which-key
nvim-pack-lock.json        plugin revs — commit this after every update
```

## Updating plugins

`<leader>l` runs `vim.pack.update()` then prints the `nvim-pack-lock.json` diff.
Review the diff, then commit the lockfile so updates are auditable in git history.

## Keymap cheatsheet

Leader is `<Space>`.

| keys | action |
| --- | --- |
| `<leader><space>` | fzf files (git root) |
| `<leader>/` | live grep (root) |
| `<leader>,` | buffers picker |
| `<leader>:` | command history |
| `<leader>e` / `<leader>E` | snacks explorer |
| `<leader>n` | notification history |
| `<leader>l` | update plugins (then shows lockfile diff) |
| `<leader>bd` / `<leader>bo` / `<leader>bD` | delete buffer / others / buffer+window |
| `<leader>bj` | pick buffer (bufferline) |
| `<S-h>` / `<S-l>` | prev / next buffer |
| `<leader>-` / `<leader>\|` | split below / right |
| `<leader>wd` | delete window |
| `<C-h/j/k/l>` | move between windows |
| `<A-j>` / `<A-k>` | move line down / up |
| `<leader>gd` / `<leader>gD` / `<leader>gs` / `<leader>gi` | git diff hunks / vs origin / status / GH issues |
| `<leader>us` / `<leader>uw` | toggle spell / wrap |

LSP (active when an LSP attaches):

| keys | action |
| --- | --- |
| `gd` / `gD` / `gr` / `gI` / `gy` | definition / declaration / references / impl / type |
| `K` / `gK` | hover / signature help |
| `<leader>ca` / `<leader>cr` / `<leader>cf` | code action / rename / format |
| `<leader>cd` | line diagnostics |
| `]d` / `[d` / `]e` / `[e` / `]w` / `[w` | next/prev diagnostic / error / warning |
| `<leader>cs` / `<leader>cS` | document / workspace symbols |

## Security posture

This config is deliberately conservative about supply-chain risk. Do not undo
the following without thinking about it:

- **No auto-install at startup.** `:MasonEnsure` and `:TSEnsure` are user
  commands, not startup loops. Mason fetches binaries from npm/PyPI/GitHub
  releases without signature verification; treesitter compiles parsers from
  source. Both should be intentional acts.
- **No `PackChanged` -> `TSUpdate` autocmd.** Updating treesitter parsers
  triggers fetches and `cc` compilation; gate it behind `:TSEnsure` instead.
- **`blink.cmp` is pinned to `^1`.** Bump the major in `lua/config/plugins.lua`
  only after reading release notes.
- **`snacks.image` is disabled.** It shells out to ImageMagick / Ghostscript /
  kitty graphics; broad decoder surface for a feature this config doesn't use.
- **`<leader>l` shows the lockfile diff.** Don't merge updates blind.
- **fzf-lua uses `--follow`** (`lua/plugins/utils.lua`). If you cd into an
  untrusted repo, the picker will traverse symlinks out of the project. Drop
  `--follow` if that bothers you.

## Notes / gotchas

- `nvim-treesitter` tracks the `main` branch (the new API). Switching to
  `master` would require rewriting `lua/plugins/treesitter.lua` to use
  `nvim-treesitter.configs`.
- Format-on-save (`lua/plugins/lsp.lua`) runs `vim.lsp.buf.format` on every
  buffer except `sh`. Project-local LSP config (`.luarc.json`,
  `pyrightconfig.json`, etc.) is trusted implicitly when a server attaches.
- Clipboard sync is disabled over SSH (`options.lua`) so OSC 52 works without
  leaking the system clipboard.
- Derived in part from LazyVim — see `NOTICE`.
