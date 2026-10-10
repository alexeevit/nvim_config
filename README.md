# My Neovim config

Vimscript config for Neovim 0.12+ on macOS, with plugins managed by [vim-plug](https://github.com/junegunn/vim-plug).

## Installation

### 1. System dependencies

Install the Xcode Command Line Tools (C compiler for Treesitter parsers, plus `git`, `curl` and `tar`):

```sh
xcode-select --install
```

Then install the rest with [Homebrew](https://brew.sh):

```sh
brew install neovim deno ripgrep uv tree-sitter-cli glib go
```

| Package | Used by |
|---|---|
| `neovim` | 0.12 or newer, required by nvim-treesitter's `main` branch |
| `deno` | denops, which runs the ddu file browser |
| `ripgrep` | Denite file search (`<leader>t`) and grep (`<leader>f`) |
| `uv` | creating the Python environment for Denite |
| `tree-sitter-cli` | building Treesitter parsers (0.26.1 or newer; don't install it from npm) |
| `glib` | `gio trash`, used by the file browser's `D` (move to trash) |
| `go` | vim-go, which installs its Go tools (`gopls` and others) during plugin install |

### 2. Clone the config

```sh
git clone <repo-url> ~/.config/nvim
```

### 3. Python environment

Denite is a Python remote plugin. The config points Neovim at a dedicated virtualenv inside the config directory (`.python-venv`, ignored by git):

```sh
uv venv ~/.config/nvim/.python-venv
uv pip install --python ~/.config/nvim/.python-venv pynvim
```

Create it before installing plugins, or Denite's remote plugin won't register.

### 4. vim-plug

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 5. Install plugins

```sh
nvim --headless +'PlugInstall --sync' +qa
```

This takes a minute or two. It prints errors about `iceberg`, `ddu#custom#patch_local` and `nvim-treesitter` because the config loads before the plugins exist; that's expected on this first run only. Plugin install hooks also run here: Denite's `:UpdateRemotePlugins` and vim-go's `:GoUpdateBinaries`.

### 6. First start

Open `nvim` normally. The Treesitter parsers (`ruby`, `javascript`, `embedded_template`, `html`) build in the background on this start; files opened after they finish get Treesitter highlighting.

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
| `denite.vim` | Denite: buffer list, file search, grep |
| `ddu.vim`, `ddu/files-browser.vim` | ddu sidebar file browser |
| `easymotion.vim` | EasyMotion jumps |
| `lightline.vim` | status line |
| `colorscheme.vim` | iceberg theme, follows macOS light/dark appearance |
| `indent_guides.vim` | indent guide settings |
| `lua/treesitter.lua` | Treesitter parsers and highlighting |

Highlights:

- **Theme**: iceberg. Light or dark follows the macOS appearance, checked at startup and whenever Neovim regains focus.
- **Treesitter**: highlighting for every filetype with a parser, including Neovim's bundled ones (Lua, Vim, Markdown, C, help). Other languages use their syntax plugins (vim-go, rust.vim, python-syntax, php.vim, yats.vim, vim-jsx-pretty, vim-coffee-script, vim-json, nginx.vim).
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

### Denite

| Keys | Action |
|---|---|
| `<leader>;` | open buffers |
| `<leader>t` | files in the project (ripgrep, respects `.gitignore`) |
| `<leader>f` | grep the current directory |

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
