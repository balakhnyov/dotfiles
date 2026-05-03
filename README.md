# My Dotfiles - Gruvbox Themed

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

![Gruvbox Themed](gruvbox-theme.png)

## What's inside

| Package | Description |
|---------|-------------|
| `nvim` | Neovim (LazyVim, Gruvbox, Telescope, LSP) |
| `tmux` | tmux (tpm, gruvbox, resurrect, continuum) |
| `zshrc` | Zsh config for Linux |
| `zshrc-macos` | Zsh config for macOS (oh-my-zsh, hstr, fzf, lsd) |
| `hyprland` | Hyprland window manager |
| `waybar` | Waybar status bar |
| `kitty` | Kitty terminal |
| `wofi` | Wofi launcher |
| `hypridle` | Hyprland idle daemon |
| `hyprlock` | Hyprland lock screen |
| `hyprpaper` | Hyprland wallpaper |
| `hyprgruv` | Gruvbox theme for Hyprland |
| `backgrounds` | Wallpapers |

## Automatic installation

### macOS

```sh
git clone git@github.com:balakhnyov/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-macos.sh
```

Installs everything for a macOS setup:
- Homebrew (if missing), then `stow`, `neovim`, `tmux`, `lsd`, `fd`, `fzf`, `hstr`
- oh-my-zsh + plugins (zsh-autosuggestions, zsh-syntax-highlighting)
- tpm (tmux plugin manager)
- Links: `nvim`, `tmux`, `zshrc-macos`

### Universal (auto-detects OS)

```sh
git clone git@github.com:balakhnyov/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
- Install `stow` if missing (brew/apt/pacman)
- Install oh-my-zsh and plugins (zsh-autosuggestions, zsh-syntax-highlighting)
- Install tmux plugin manager (tpm)
- Detect OS and pick the right zshrc (`zshrc-macos` on macOS, `zshrc` on Linux)
- On Linux, also link Hyprland, Waybar, Kitty, Wofi and other configs
- Back up any conflicting files to `*.bak`

## Manual installation

### 1. Prerequisites

```sh
# macOS
brew install stow

# Arch
sudo pacman -S stow

# Debian/Ubuntu
sudo apt install stow
```

### 2. Clone and link

```sh
git clone git@github.com:balakhnyov/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Choose the packages you need:

```sh
# Neovim + tmux (any OS)
stow nvim
stow tmux

# Zsh — pick one
stow zshrc-macos   # macOS
stow zshrc          # Linux

# Linux desktop (Hyprland)
stow hyprland hypridle hyprlock hyprpaper hyprgruv waybar wofi kitty backgrounds
```

If stow reports conflicts, back up and retry:

```sh
mv ~/.zshrc ~/.zshrc.bak
stow zshrc-macos
```

### 3. Post-install

**oh-my-zsh** (if using zshrc-macos or zshrc):

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

**tmux plugins**: open tmux and press `prefix + I` to install via tpm.

## Tools used

- [Hyprland](https://hyprland.org/) — Wayland compositor
- [Waybar](https://github.com/Alexays/Waybar) — status bar
- [Neovim](https://neovim.io/) + [LazyVim](https://www.lazyvim.org/) — editor
- [tmux](https://github.com/tmux/tmux) — terminal multiplexer
- [Zsh](https://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/) — shell
- [GNU Stow](https://www.gnu.org/software/stow/) — symlink manager
