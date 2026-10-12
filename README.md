# My Neovim config

Vimscript config for Neovim 0.12+ on macOS, with plugins managed by [vim-plug](https://github.com/junegunn/vim-plug). Works in terminal `nvim` and in [VimR](https://github.com/qvacua/vimr), which bundles its own Neovim; that copy must also be 0.12 or newer.

## Installation

### 1. System dependencies

Install the Xcode Command Line Tools (C compiler for Treesitter parsers, plus `git`, `curl` and `tar`):

```sh
xcode-select --install
```

Then install the rest with [Homebrew](https://brew.sh):

```sh
brew install neovim deno ripgrep tree-sitter-cli glib go
```

| Package | Used by |
|---|---|
| `neovim` | 0.12 or newer, required by nvim-treesitter's `main` branch |
| `deno` | denops, which runs ddu: the file browser and the finders |
| `ripgrep` | file finder (`<leader>t`) and grep (`<leader>f`) |
| `tree-sitter-cli` | building Treesitter parsers (0.26.1 or newer; don't install it from npm) |
| `glib` | `gio trash`, used by the file browser's `D` (move to trash) |
| `go` | vim-go, which installs its Go tools (`gopls` and others) during plugin install |

### 2. Clone the config

```sh
git clone <repo-url> ~/.config/nvim
```

### 3. vim-plug

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 4. Install plugins

```sh
nvim --headless +'PlugInstall --sync' +qa
```

This takes a minute or two. It prints errors about `iceberg`, `ddu#custom#patch_local` and `nvim-treesitter` because the config loads before the plugins exist; that's expected on this first run only. vim-go's install hook, `:GoUpdateBinaries`, also runs here.

### 5. First start

Open `nvim` normally. The Treesitter parsers (`ruby`, `javascript`, `embedded_template`, `html`, `go`, `rust`, `python`, `php`, `typescript`, `tsx`, `json`) build in the background on this start; files opened after they finish get Treesitter highlighting.

Check that everything is in place:

```vim
:checkhealth
```

## Updating

```vim
:PlugUpdate
```

The nvim-treesitter install hook runs `:TSUpdate` afterwards, which keeps the parsers in step with the plugin. nvim-treesitter requires this after every plugin upgrade.

## What's in it

| File | Contents |
|---|---|
| `init.vim` | entry point: providers, general options, filetype tweaks; loads the files below |
| `plugins.vim` | plugin list |
| `bindings.vim` | general key mappings, leader keys |
| `ddu.vim` | loads the ddu files below |
| `ddu/files-browser.vim` | sidebar file browser |
| `ddu/finder.vim` | file finder, grep and buffer list |
| `denops/@ddu-filters/sorter_length/` | ddu sorter that ranks equally good fuzzy matches shortest path first |
| `easymotion.vim` | EasyMotion jumps |
| `lightline.vim` | status line |
| `colorscheme.vim` | iceberg theme, follows macOS light/dark appearance |
| `indent_guides.vim` | indent guide settings |
| `lua/treesitter.lua` | Treesitter parsers and highlighting |

Highlights:

- **Theme**: iceberg. Light or dark follows the macOS appearance, checked at startup and whenever Neovim regains focus.
- **Treesitter**: highlighting for every filetype with a parser, including Neovim's bundled ones (Lua, Vim, Markdown, C, help). Regex syntax keeps running underneath because indent scripts rely on it. Language plugins add what Treesitter doesn't: vim-go and rust.vim (commands, formatting), PHP-Indenting-for-VIm and vim-jsx-pretty (indentation), vim-blade, vim-coffee-script and nginx.vim (filetypes without a parser here).
- **Russian layout**: normal-mode commands work on a Russian keyboard layout (`langmap`), and `ж`/`Ж` enter command mode.
- **Clipboard**: yank and paste use the system clipboard.
- **No swap or backup files.**
- **Trailing whitespace** is highlighted (vim-better-whitespace).
- **`file:line:col`**: `nvim app.rb:12:3` opens at that position (vim-fetch).
- **Git**: change signs in the sign column (vim-gitgutter), branch in the status line.

## Key mappings

Leader is `Space`; local leader is `,`.

### General

| Keys | Action |
|---|---|
| `jk`, `JK` | leave insert mode |
| `Esc` | clear search highlight |
| `Ctrl-h/j/k/l` | move between windows |
| `j`, `k` | move by display line on wrapped text |
| `Ctrl-p` | paste the last yank (not the last delete) |
| `<`, `>` in visual mode | shift indent and keep the selection |
| `th` / `tl` | first / last tab |
| `tk` / `tj` | next / previous tab |
| `tn` | new tab |
| `td` | close tab |

The `t`-prefixed mappings replace Vim's `t{char}` motion for those letters.

### Finders (ddu)

A floating list at the top of the screen with a fuzzy filter prompt below it. Start typing as soon as it opens.

| Keys | Action |
|---|---|
| `<leader>t` | files in the project (from the nearest `.git` up; ripgrep, respects `.gitignore`) |
| `<leader>f` | grep the current directory: enter a pattern (regex, smart case, includes hidden files), then filter the matches |
| `<leader>;` | open buffers |

In the filter prompt: `Enter` opens, `Ctrl-t` / `Ctrl-v` / `Ctrl-s` open in a tab / vertical split / split, `Ctrl-o` jumps to the results, `Esc` quits.

In the results: `Enter` opens, `Ctrl-t` / `Ctrl-v` / `Ctrl-s` as above, `p` previews, `d` closes the buffer (buffer list only), `i` or `Ctrl-o` goes back to the filter, `q` or `Esc` quits.

### File browser (ddu)

| Keys | Action |
|---|---|
| `tt` | toggle the sidebar |
| `tf` | open the sidebar at the current file |

Inside the sidebar:

| Keys | Action |
|---|---|
| `Enter` | open |
| `l` | open a file, or enter a directory |
| `h` | go to the parent directory |
| `o` / `O` | expand or collapse a directory / expand everything below it |
| `Ctrl-t` / `Ctrl-v` / `Ctrl-s` | open in a tab / vertical split / split |
| `%` / `K` | new file / new directory |
| `r` | rename |
| `c` | copy |
| `x` or `m` | cut |
| `p` | paste |
| `u` | undo the last file operation |
| `dd` | delete |
| `D` | move to trash |
| `.` | show or hide dotfiles |
| `Ctrl-r` | refresh |
| `q` | close |

### EasyMotion

| Keys | Action |
|---|---|
| `<leader>s` | jump to a two-character match in any window |
| `<leader>j` / `<leader>k` | jump to a line below / above |
| `<leader>w` `W` `e` `E` `b` `B` `ge` `gE` | jump to a word start or end, like the matching Vim motion |
