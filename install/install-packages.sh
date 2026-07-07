#!/usr/bin/env sh
# chezmoi: run once on Linux — installs developer tools via the system package manager.
[ "$(uname)" = "Linux" ] || exit 0

PKGS_ARCH="git neovim zsh starship fzf zoxide bat eza fd ripgrep lazygit git-delta tmux
           alacritty kitty dunst i3-wm i3blocks sxhkd mpd python nodejs npm wget vim
           zathura python-psutil dmenu xclip pamixer mpc libnotify"

PKGS_DEB="git neovim zsh fzf zoxide bat ripgrep tmux
          alacritty kitty dunst i3 i3blocks sxhkd mpd python3 nodejs npm wget vim
          suckless-tools xclip pamixer mpc libnotify-bin"

PKGS_DNF="git neovim zsh fzf zoxide bat eza fd-find ripgrep lazygit git-delta tmux
          alacritty kitty dunst i3 i3blocks sxhkd mpd python3 nodejs npm wget vim
          dmenu xclip pamixer mpc libnotify"

if command -v pacman > /dev/null 2>&1; then
    sudo pacman -S --noconfirm --needed $PKGS_ARCH

elif command -v apt > /dev/null 2>&1; then
    sudo apt update
    sudo apt install -y $PKGS_DEB
    # eza and starship aren't in standard apt repos
    if ! command -v eza > /dev/null 2>&1; then
        cargo install eza 2>/dev/null || true
    fi
    if ! command -v starship > /dev/null 2>&1; then
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
    fi
    if ! command -v delta > /dev/null 2>&1; then
        cargo install git-delta 2>/dev/null || true
    fi

elif command -v dnf > /dev/null 2>&1; then
    sudo dnf install -y $PKGS_DNF
    if ! command -v starship > /dev/null 2>&1; then
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
    fi
fi

# XDG dirs for tools that need them
mkdir -p \
    "$HOME/.local/share/vim" \
    "$HOME/.local/state/vim" \
    "$HOME/.local/state/zsh" \
    "$HOME/.local/share/python" \
    "$HOME/.cache/zsh" \
    "$HOME/.cache/X11"
