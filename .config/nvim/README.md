# nvim

My personal [Neovim](https://neovim.io) configuration for Linux and macOS. Plugins are managed by
`vim.pack`, Neovim's built-in package manager, so there is no third-party plugin manager and no
bootstrap step.

![cover](nvim.png)

## Requirements

- Neovim 0.12 or newer. The config relies on `vim.pack`, `vim.lsp.enable()`, `:restart`, and the
  bundled `nvim.undotree` plugin, none of which exist in 0.11.
- `git`, on `$PATH` (used by `vim.pack` to clone and update plugins).
- A terminal with true-colour support: [Ghostty](https://ghostty.org),
  [kitty](https://sw.kovidgoyal.net/kitty), [WezTerm](https://wezfurlong.org/wezterm),
  [Alacritty](https://alacritty.org). Full list in the
  [termstandard](https://github.com/termstandard/colors#terminal-emulators) repo.
- A [Nerd Font](https://www.nerdfonts.com) for the icons. Set `vim.g.nerd_fonts = false` in
  `lua/core/init.lua` to fall back to text.
- [fd](https://github.com/sharkdp/fd) and [ripgrep](https://github.com/BurntSushi/ripgrep) for
  `snacks.picker`'s file and grep sources.
- Optional: `tmux` for pane navigation, `cargo` to build blink.cmp's native fuzzy matcher, and the
  Go / .NET toolchains for their debug adapters.

## Install

This config lives in my [dotfiles](https://github.com/djamseed-khodabocus-cko/dotfiles) repo and is
symlinked into place by `install.sh` there. To use it on its own:

```sh
git clone <this-repo> ~/.config/nvim
nvim
```

On the first start `vim.pack` clones every plugin listed in the `vim.pack.add()` calls under
`lua/plugins/`, then a `PackChanged` autocmd runs the post-install steps (`:TSUpdate` for
treesitter, `cargo build --release` for blink.cmp). Mason installs the language servers, formatters
and debug adapters in the background. Restart once it settles.

## Layout

```
init.lua                 vim.loader, experimental message/cmdline UI, entry point
lua/core/
  init.lua               disable unused runtime plugins, leader key, load order
  options.lua            vim.opt settings
  keymaps.lua            editor keymaps
  autocmds.lua           yank highlight, cursorline, last-location, q-to-close
  lsp.lua                LspAttach keymaps, diagnostic config, vim.lsp.enable()
lua/plugins/
  init.lua               auto-requires every sibling module, PackChanged build hooks
  *.lua                  one module per plugin or plugin group
lsp/<server>.lua         native vim.lsp.config specs, picked up by vim.lsp.enable()
after/ftplugin/*.lua     per-filetype defaults, overridden by guess-indent when it detects
nvim-pack-lock.json      plugin revisions, written by vim.pack (gitignored)
```

`lua/plugins/init.lua` walks the `lua/plugins` directory, sorts the results and requires each one,
so adding a plugin means dropping in a new file. Each module calls `vim.pack.add()` for its
dependencies and then configures them. `debug.lua` only calls `vim.pack.add()` at startup and
defers its requires to the first debug keymap.

## Plugin management

`vim.pack` replaces lazy.nvim. The commands are:

| Command | Effect |
| --- | --- |
| `:lua vim.pack.update()` | Fetch updates, show a diff buffer, confirm with `:write` |
| `:lua vim.pack.update(nil, { force = true })` | Update without the confirmation buffer |
| `:lua vim.pack.get()` | List installed plugins and their revisions |
| `:lua vim.pack.del({ 'name' })` | Remove a plugin |

Plugins install into `~/.local/share/nvim/site/pack/core/opt/`. Revisions are recorded in
`nvim-pack-lock.json`, which is gitignored: `vim.pack` regenerates it on install and update, so a
fresh clone resolves each plugin's default branch (or the `version` range in its spec) rather than
a pinned revision.

## What is included

- Theme: [oxocarbon](https://github.com/nyoom-engineering/oxocarbon.nvim)
- QoL collection: [snacks](https://github.com/folke/snacks.nvim) — picker, explorer, dashboard,
  notifier, statuscolumn, bigfile, quickfile, scope, indent guides, image preview
- Statusline: [lualine](https://github.com/nvim-lualine/lualine.nvim)
- Keymap hints: [which-key](https://github.com/folke/which-key.nvim)
- Git signs and hunk actions: [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- tmux pane navigation: [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- Parsing and highlighting: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  (`main` branch) with
  [context](https://github.com/nvim-treesitter/nvim-treesitter-context) and
  [textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- Editing helpers from [mini.nvim](https://github.com/nvim-mini/mini.nvim): `mini.ai`,
  `mini.pairs`, `mini.surround`, `mini.icons`
- LSP: Neovim's [native client](https://neovim.io/doc/user/lsp.html), one file per server under
  `lsp/`, plus [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) for C#
- Completion and snippets: [blink.cmp](https://github.com/Saghen/blink.cmp) (pinned to `1.*`) with
  [friendly-snippets](https://github.com/rafamadriz/friendly-snippets). Sources are LSP, path,
  snippets, buffer and Copilot.
- Copilot: [copilot.lua](https://github.com/zbirenbaum/copilot.lua) as the client, set up on the
  first `InsertEnter`, feeding blink through
  [blink-cmp-copilot](https://github.com/giuxtaposition/blink-cmp-copilot). Copilot's own inline
  suggestions and panel are off, so every completion comes from the blink menu.
- Formatting: [conform](https://github.com/stevearc/conform.nvim), format on save
- Debugging: [nvim-dap](https://github.com/mfussenegger/nvim-dap),
  [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui), with Go and .NET adapters
- Quickfix: [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
- TODO highlighting: [todo-comments](https://github.com/folke/todo-comments.nvim)
- Indent detection: [guess-indent](https://github.com/NMAC427/guess-indent.nvim), driven off
  `FileType` so it runs after `after/ftplugin`. Existing files follow their own style; new files
  fall back to the `after/ftplugin` default. `go` and `terraform` are excluded, since gofmt and
  `terraform fmt` enforce a fixed style.
- Tool installer: [mason](https://github.com/mason-org/mason.nvim) with
  [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) and
  [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim)

Built-in features in use instead of plugins: `vim.pack` for packages, native LSP and diagnostics,
`vim.treesitter.foldexpr()` for folding, the bundled `nvim.undotree`, and the experimental
message/cmdline UI enabled in `init.lua`.

## Language servers

Enabled in `lua/core/lsp.lua`: `bashls`, `buf_ls`, `gopls`, `htmx`, `jsonls`, `lua_ls`, `ruff`,
`terraform_ls`, `yamlls`. C# is handled by `roslyn.nvim` against the `roslyn` mason package.

SQL has no language server: `sql-language-server` is unmaintained and crashes on Node 18+. SQL files
get treesitter highlighting and `sql_formatter` on save.

To add a server, drop a `lsp/<name>.lua` returning a `vim.lsp.Config` table and add its name to the
`vim.lsp.enable()` list. Add the corresponding mason package to `lua/plugins/mason.lua`.

## Keymaps

Leader is `<Space>`. `which-key` lists everything under a prefix; `<leader>fk` searches all keymaps.

### Editing

| Key | Action |
| --- | --- |
| `<C-s>` | Write the buffer |
| `<C-d>` / `<C-u>` | Half-page scroll, cursor centred |
| `n` / `N` | Next / previous search hit, centred |
| `J` / `K` (visual) | Move the selection down / up |
| `<` / `>` (visual) | Reindent and keep the selection |
| `p` / `P` (visual) | Paste over the selection without clobbering the register |
| `d` / `x` | Delete into the black hole register |
| `<leader>u` | Undo tree |
| `<leader>q` | Close the window |
| `<leader>r` | Restart Neovim |
| `sa` / `sd` / `sr` | Add / delete / replace a surrounding pair |

### Navigation

| Key | Action |
| --- | --- |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between splits and tmux panes |
| `<C-\>` | Previous tmux pane |
| `<C-A-arrows>` | Resize the window |
| `\` | Toggle the file explorer |

### Find

| Key | Action |
| --- | --- |
| `<leader>ff` | Files |
| `<leader>fg` | Git-tracked files |
| `<leader>fs` | Grep the project |
| `<leader>fw` | Grep the word under the cursor |
| `<leader>f/` | Search the current buffer |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |
| `<leader>fq` | Quickfix list |
| `<leader>ft` | TODO comments |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |

### LSP

| Key | Action |
| --- | --- |
| `K` | Hover |
| `gd` / `gD` | Definition / declaration |
| `gri` / `grt` | Implementation / type definition |
| `grr` | References |
| `grn` | Rename |
| `gra` | Code action |
| `gO` | Document symbols |
| `gs` | Signature help |
| `<leader>d` / `<leader>D` | Buffer / workspace diagnostics to the quickfix list |
| `<leader>cf` | Format the buffer |
| `<leader>th` | Toggle inlay hints |

### Git

| Key | Action |
| --- | --- |
| `<leader>gs` / `<leader>gS` | Stage hunk / buffer |
| `<leader>gr` / `<leader>gR` | Reset hunk / buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gp` / `<leader>gP` | Preview hunk in a float / inline |
| `<leader>gd` | Diff against the index |
| `<leader>gb` | Blame the current line |

### Debug

| Key | Action |
| --- | --- |
| `<F5>` | Start / continue |
| `<F7>` / `<F8>` / `<S-F8>` | Step into / over / out |
| `<F9>` | Toggle the DAP UI |
| `<leader>bb` | Toggle a breakpoint |
| `<leader>B` | Set a conditional breakpoint (prompts for the condition) |
| `<leader>bc` | Clear all breakpoints |

The dap stack loads on the first of these keymaps, not at startup.

### Toggles

`<leader>ti` indent guides, `<leader>tw` wrap, `<leader>th` inlay hints.

## Health

`:checkhealth` for the general report, `:checkhealth vim.lsp` (aliased to `:LspInfo`) for attached
clients, `:Mason` for tool installs, `:lua vim.pack.get()` for plugin state.
