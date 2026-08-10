#!/bin/bash
# dotfiles — symlink installer.
# Mirrors every tracked file in this repo (except this script, README.md,
# pkglist.txt, aurlist.txt, zsh/*) into the matching path under ~/.config.
# zsh/* is special-cased below since it lives outside ~/.config.
# Existing real files (not symlinks) are backed up with a .bak suffix.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_BASE="$HOME/.config"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✔${NC}  $*"; }
warn() { echo -e "${YELLOW}  !${NC}  $*"; }

link() {
    local src="$1" target="$2" label="$3"
    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        ln -sf "$src" "$target"
        ok "$label (relinked)"
    elif [[ -e "$target" ]]; then
        mv "$target" "$target.bak"
        ln -s "$src" "$target"
        warn "$label (existing file backed up to $label.bak, then linked)"
    else
        ln -s "$src" "$target"
        ok "$label (linked)"
    fi
}

cd "$DOTFILES_DIR"

# zsh: not under ~/.config, so it's linked to its real target explicitly.
# Requires oh-my-zsh already installed (see README).
link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc" ".zshrc"
link "$DOTFILES_DIR/zsh/shell.zsh-theme" "$HOME/.zsh/shell.zsh-theme" ".zsh/shell.zsh-theme"

while IFS= read -r -d '' file; do
    rel="${file#./}"

    case "$rel" in
        install.sh|README.md|pkglist.txt|aurlist.txt) continue ;;
        zsh/*) continue ;;
    esac

    target="$TARGET_BASE/$rel"
    link "$DOTFILES_DIR/$rel" "$target" "$rel"
done < <(find . -type f -not -path "./.git/*" -print0)

echo
echo "Done. Now:"
echo "  1. Reinstale os pacotes: pacman -S --needed - < pkglist.txt"
echo "  2. yay -S --needed - < aurlist.txt"
echo "  3. Clone e rode ~/projects/yoru/install.sh"
echo "  4. Veja o README.md deste repo — tem pendências manuais (cursor theme, permissões do Hyprland)"