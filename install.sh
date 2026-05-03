#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

info()  { printf "\033[1;34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[1;33m[warn]\033[0m  %s\n" "$1"; }
error() { printf "\033[1;31m[error]\033[0m %s\n" "$1"; exit 1; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

install_stow() {
    if command_exists stow; then
        ok "stow already installed"
        return
    fi
    info "Installing stow..."
    if command_exists brew; then
        brew install stow
    elif command_exists apt; then
        sudo apt install -y stow
    elif command_exists pacman; then
        sudo pacman -S --noconfirm stow
    else
        error "Could not install stow: no supported package manager found (brew/apt/pacman)"
    fi
}

install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        ok "oh-my-zsh already installed"
    else
        info "Installing oh-my-zsh..."
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [ -d "$custom/plugins/zsh-autosuggestions" ]; then
        ok "zsh-autosuggestions already installed"
    else
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$custom/plugins/zsh-autosuggestions"
    fi

    if [ -d "$custom/plugins/zsh-syntax-highlighting" ]; then
        ok "zsh-syntax-highlighting already installed"
    else
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$custom/plugins/zsh-syntax-highlighting"
    fi
}

install_tpm() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        ok "tpm already installed"
    else
        info "Installing tmux plugin manager (tpm)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}

backup_and_stow() {
    local package="$1"
    info "Stowing $package..."

    if stow -n -d "$DOTFILES_DIR" -t "$HOME" "$package" 2>/dev/null; then
        stow -d "$DOTFILES_DIR" -t "$HOME" "$package"
        ok "$package linked"
    else
        warn "$package has conflicts, backing up existing files..."
        stow -n -d "$DOTFILES_DIR" -t "$HOME" "$package" 2>&1 \
            | grep "existing target" \
            | sed 's/.*existing target is neither a link nor a directory: //' \
            | while read -r file; do
                if [ -e "$HOME/$file" ]; then
                    mv "$HOME/$file" "$HOME/${file}.bak"
                    warn "Backed up ~/$file -> ~/${file}.bak"
                fi
            done
        stow -d "$DOTFILES_DIR" -t "$HOME" "$package"
        ok "$package linked (conflicts backed up)"
    fi
}

# --- Main ---

echo ""
echo "  Dotfiles installer"
echo "  OS detected: $OS"
echo ""

install_stow

# Common packages (any OS)
COMMON_PACKAGES=(nvim tmux)

# OS-specific zshrc
if [ "$OS" = "Darwin" ]; then
    ZSH_PACKAGE="zshrc-macos"
else
    ZSH_PACKAGE="zshrc"
fi

# Linux-only packages (Hyprland ecosystem)
LINUX_PACKAGES=(hyprland hypridle hyprlock hyprpaper hyprgruv waybar wofi kitty backgrounds)

echo "Packages to install:"
echo "  Common:   ${COMMON_PACKAGES[*]}"
echo "  Zsh:      $ZSH_PACKAGE"
[ "$OS" = "Linux" ] && echo "  Linux:    ${LINUX_PACKAGES[*]}"
echo ""

read -rp "Continue? [Y/n] " confirm
if [[ -n "$confirm" && ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# Install dependencies
install_oh_my_zsh
install_tpm

# Stow common packages
for pkg in "${COMMON_PACKAGES[@]}"; do
    backup_and_stow "$pkg"
done

# Stow zsh config
backup_and_stow "$ZSH_PACKAGE"

# Stow Linux packages
if [ "$OS" = "Linux" ]; then
    for pkg in "${LINUX_PACKAGES[@]}"; do
        backup_and_stow "$pkg"
    done
fi

echo ""
ok "Done! Restart your shell and run 'prefix + I' in tmux to install plugins."
