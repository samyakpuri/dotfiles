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

If you cloned this repo yourself instead of letting chezmoi do it, point chezmoi at the existing checkout instead of re-cloning:

```sh
chezmoi init --apply --source /path/to/dotfiles
```

```powershell
chezmoi init --apply --source C:\path\to\dotfiles
```

## Layout

- `home/` — chezmoi source directory (set via `.chezmoiroot`)
  - `dot_config/` → `~/.config/*`, cross-platform configs
  - `windows_dot_config/`, `windows_dot_Documents/` — Windows-only, applied only on Windows
  - `linux_run_once_before_install-packages.sh` — installs tools via pacman/apt/dnf
  - `windows_run_onchange_after_windows-links.ps1` — creates Windows AppData junctions for tools that don't read XDG paths
  - `.chezmoiignore.tmpl` — excludes Linux-only configs (i3, qtile, dunst, etc.) on non-Linux
- `install/install-tools.ps1` — winget package list (also invoked by chezmoi)
- `install/ssh-shell.ps1` — configures Windows OpenSSH default shell (run manually, needs admin)

## Updating

```sh
chezmoi edit ~/.config/nvim/init.lua   # opens the source file
chezmoi apply                          # apply changes
chezmoi diff                           # preview before applying
```
