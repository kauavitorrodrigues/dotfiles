# dotfiles

Configs de desktop (Arch + Hyprland + Quickshell), voltado pra máquina de
dev. Este repo mais o repo `yoru` formam a stack.

## Repos relacionados

- [yoru](https://github.com/kauavitorrodrigues/yoru) — shell Quickshell customizado. Tem seu próprio `install.sh` (dependências, sink virtual do Spotify, roteamento WirePlumber, cava, symlink pro Quickshell).

## O que tem aqui

Cada diretório espelha `~/.config/<nome>`. `install.sh` cria symlinks
automaticamente (backup de qualquer arquivo real que já exista com sufixo `.bak`).

| Pasta         | Vai pra                          | Observação |
|---------------|-----------------------------------|------------|
| `hypr/`       | `~/.config/hypr/`                 | Só `hyprland.lua` — ver nota abaixo |
| `kitty/`      | `~/.config/kitty/`                 | |
| `rofi/`       | `~/.config/rofi/`                  | |
| `swaync/`     | `~/.config/swaync/`                | |
| `fastfetch/`  | `~/.config/fastfetch/`             | |
| `qt5ct/`      | `~/.config/qt5ct/`                 | só `qt5ct.conf` — cores/qss ficaram default no sistema atual, não foram customizados |
| `qt6ct/`      | `~/.config/qt6ct/`                 | idem |
| `gtk-3.0/`    | `~/.config/gtk-3.0/`               | só `settings.ini` |
| `zed/`        | `~/.config/zed/`                   | settings, keymap, tasks |
| `systemd/user`| `~/.config/systemd/user/`          | só `cameractrlsd.service` (os outros .service que existem no desktop atual são gerados pelos próprios pacotes: pipewire, wireplumber) |
| `mimeapps.list`| `~/.config/mimeapps.list`         | associações de app padrão (zen-browser etc.) |
| `pkglist.txt` / `aurlist.txt` | — (não são linkados) | export de `pacman -Qqe` / AUR pra reinstalar pacotes |

## Hyprland: só Lua, não `.conf`

A partir da 0.55, o Hyprland lê `~/.config/hypr/hyprland.lua` se ele existir,
e só cai pro `.conf` como fallback legado. Por isso este repo só versiona
o `.lua` — o `.conf` antigo foi removido do tracking (ainda existe no
histórico do git se precisar consultar).

**Pendências dentro do `hyprland.lua`** (marcadas com `TODO` no arquivo): as
seções de `permissions`, `gesture` (3 dedos = trocar workspace) e `device`
(regras por periférico: mouse Beken 2.4G, teclado Husky Hailstorm) estavam
comentadas no Lua porque não tínhamos confirmação de que `hl.permission()` /
`hl.gesture()` / `hl.device()` existem com essa assinatura na versão do
Hyprland instalada. Elas funcionam hoje no `.conf` antigo. Antes de depender
delas na máquina nova, checa a wiki/changelog do Hyprland pra versão que for
instalar lá.

## Coisas que NÃO estão neste repo (dependem de ação manual)

- **Cursor "Polarnight-cursors"** — está em `/usr/share/icons/Polarnight-cursors`
  no desktop atual, mas **não é gerenciado por nenhum pacote** (`pacman -Qo`
  não acha dono). Foi instalado manualmente em algum momento — precisa achar
  a fonte original (AUR? GitHub?) e documentar aqui, senão o notebook fica
  sem o cursor certo mesmo seguindo todo o resto deste guia.
- **`cameractrls`** — o pacote existe (`cameractrls 0.6.10-2`) mas não apareceu
  no `pkglist.txt` exportado; adiciona manualmente na hora de instalar pacotes
  no notebook se a webcam precisar do daemon de controle.
- **Credenciais** (`gh auth login`, chaves SSH, etc.) — de propósito fora do
  repo, nunca versionar.

## Setup em máquina nova

```bash
git clone https://github.com/kauavitorrodrigues/dotfiles.git ~/personal/dotfiles
cd ~/personal/dotfiles

sudo pacman -S --needed - < pkglist.txt
yay -S --needed - < aurlist.txt

./install.sh   # symlinka tudo pra ~/.config

git clone https://github.com/kauavitorrodrigues/yoru.git ~/projects/yoru
~/projects/yoru/install.sh
```
