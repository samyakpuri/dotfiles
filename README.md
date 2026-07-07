# dotfiles

My config files, managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap

Windows:

```powershell
winget install twpayne.chezmoi
chezmoi init --apply https://github.com/samyakpuri/dotfiles.git
```

Linux — install chezmoi first, then init:

```sh
# Arch
sudo pacman -S chezmoi

# Fedora
sudo dnf install chezmoi

# Ubuntu/Debian (not in apt; use the binary install script or snap)
sh -c "$(curl -fsLS get.chezmoi.io)"        # installs to ./bin/chezmoi
# or: sudo snap install chezmoi --classic

chezmoi init --apply https://github.com/samyakpuri/dotfiles.git
```

Full install matrix (all package managers/platforms): <https://www.chezmoi.io/install/>

On first run, chezmoi prompts for your git name/email and writes them to `~/.gitconfig`.

### Already cloned this repo?

If you cloned this repo yourself instead of letting chezmoi do it, point
chezmoi at the existing checkout instead of re-cloning:

```sh
chezmoi init --apply --source /path/to/dotfiles
```

```powershell
chezmoi init --apply --source C:\path\to\dotfiles
```

## Layout

- `home/` — chezmoi source directory (set via `.chezmoiroot`)
  - `dot_config/` → `~/.config/*`, cross-platform configs
  - `Documents/PowerShell/` → PowerShell profile and modules (Windows only)
  - `dot_local/bin/` → `~/.local/bin/*`, dmenu/i3/statusbar helper
    scripts (Linux only; merged from the old scripts repo with history)
  - `dot_local/share/spuri/emoji` → `~/.local/share/spuri/emoji`, emoji
    list read by `dmenuunicode` (Linux only)
  - `xorg/` — Xorg input confs, not deployed to `~`; installed to
    `/etc/X11/xorg.conf.d/` by `run_onchange_after_xorg.sh.tmpl`
    (needs sudo during `chezmoi apply`)
  - `run_onchange_after_windows-links.ps1` — creates Windows AppData
    junctions for tools that don't read XDG paths (no-ops off Windows)
  - `.chezmoiignore.tmpl` — platform split: excludes Windows-only configs
    on Linux and Linux-only configs (i3, qtile, dunst, zsh, etc.) elsewhere
- `install/` — manual bootstrap scripts, not run by chezmoi
  - `install-tools.ps1` — winget package list (Windows)
  - `install-packages.sh` — pacman/apt/dnf package list (Linux)
  - `ssh-shell.ps1` — configures Windows OpenSSH default shell (needs admin)
- `share/wallpaper.jpg` — copy manually to `~/.local/share/sp/` (qtile globs `sp/wall*`)

Keyboard layout (us-intl, CapsLock→Esc, Alt+CapsLock layout toggle) is set via
`setxkbmap` in `home/dot_config/X11/xprofile`, not an Xorg conf.

## Updating

```sh
chezmoi edit ~/.config/nvim/init.lua   # opens the source file
chezmoi apply                          # apply changes
chezmoi diff                           # preview before applying
```
