#!/bin/bash
# dotfiles — symlink installer.
# Mirrors every tracked file in this repo (except this script, README.md,
# pkglist.txt, aurlist.txt) into the matching path under ~/.config.
# Existing real files (not symlinks) are backed up with a .bak suffix.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_BASE="$HOME/.config"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✔${NC}  $*"; }
warn() { echo -e "${YELLOW}  !${NC}  $*"; }

cd "$DOTFILES_DIR"

while IFS= read -r -d '' file; do
    rel="${file#./}"

    case "$rel" in
        install.sh|README.md|pkglist.txt|aurlist.txt) continue ;;
    esac

    target="$TARGET_BASE/$rel"
    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        ln -sf "$DOTFILES_DIR/$rel" "$target"
        ok "$rel (relinked)"
    elif [[ -e "$target" ]]; then
        mv "$target" "$target.bak"
        ln -s "$DOTFILES_DIR/$rel" "$target"
        warn "$rel (existing file backed up to $rel.bak, then linked)"
    else
        ln -s "$DOTFILES_DIR/$rel" "$target"
        ok "$rel (linked)"
    fi
done < <(find . -type f -not -path "./.git/*" -print0)

echo
echo "Done. Now:"
echo "  1. Reinstale os pacotes: pacman -S --needed - < pkglist.txt"
echo "  2. yay -S --needed - < aurlist.txt"
echo "  3. Clone e rode ~/projects/yoru/install.sh"
echo "  4. Veja o README.md deste repo — tem pendências manuais (cursor theme, permissões do Hyprland)"