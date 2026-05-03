#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[1;34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[1;33m[warn]\033[0m  %s\n" "$1"; }
error() { printf "\033[1;31m[error]\033[0m %s\n" "$1"; exit 1; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

# --- Homebrew ---

install_brew() {
    if command_exists brew; then
        ok "Homebrew already installed"
    else
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# --- Brew packages ---

install_brew_packages() {
    local packages=(stow neovim tmux lsd fd fzf hstr)
    for pkg in "${packages[@]}"; do
        if brew list "$pkg" &>/dev/null; then
            ok "$pkg already installed"
        else
            info "Installing $pkg..."
            brew install "$pkg"
        fi
    done
}

# --- Oh My Zsh ---

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

# --- TPM ---

install_tpm() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        ok "tpm already installed"
    else
        info "Installing tmux plugin manager (tpm)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}

# --- Stow ---

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
echo "  macOS Dotfiles installer"
echo ""

PACKAGES=(nvim tmux zshrc-macos)

echo "This will install:"
echo "  Homebrew packages: stow, neovim, tmux, lsd, fd, fzf, hstr"
echo "  oh-my-zsh + plugins"
echo "  tpm (tmux plugin manager)"
echo "  Stow packages: ${PACKAGES[*]}"
echo ""

read -rp "Continue? [Y/n] " confirm
if [[ -n "$confirm" && ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

install_brew
install_brew_packages
install_oh_my_zsh
install_tpm

for pkg in "${PACKAGES[@]}"; do
    backup_and_stow "$pkg"
done

echo ""
ok "Done! Restart your shell and run 'prefix + I' in tmux to install plugins."
