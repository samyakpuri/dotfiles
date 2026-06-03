#!/usr/bin/env pwsh
# Installs developer tools and apps via winget.
# Designed for unattended/remote runs.

function Install($id) {
    winget install $id --accept-package-agreements --accept-source-agreements --silent
}

# ── Build Environment ──────────────────────────────────────────────
# MSVC toolchain
Install "Microsoft.VisualStudio.2022.BuildTools"
# Unix-like build env (make, gcc, autoconf, etc.)
Install "MSYS2.MSYS2"

# ── Shells & Runtimes ──────────────────────────────────────────────
Install "Microsoft.PowerShell"
# Python package/runtime manager
Install "astral-sh.uv"
# Node version manager
Install "Schniz.fnm"

# ── Editors / IDEs ────────────────────────────────────────────────
Install "Neovim.Neovim"
Install "Microsoft.VisualStudioCode"
Install "ArduinoSA.IDE.stable"

# ── Git ───────────────────────────────────────────────────────────
# Core
Install "Git.Git"
Install "Git.GCM"
Install "GitHub.GitLFS"
# GitHub integration
Install "GitHub.cli"
# TUI client
Install "JesseDuffield.lazygit"
# Repo analysis
Install "GitHub.git-sizer"

# ── Terminal & Prompt ─────────────────────────────────────────────
Install "Microsoft.WindowsTerminal"
Install "Starship.Starship"
Install "DEVCOM.JetBrainsMonoNerdFont"

# ── Shell Navigation ──────────────────────────────────────────────
# Directory jumping
Install "ajeetdsouza.zoxide"
# Fuzzy finder
Install "junegunn.fzf"
# Interactive tree navigator
Install "Dystroy.broot"

# ── File & Text Tools ─────────────────────────────────────────────
# Modern ls / cat / find
Install "eza-community.eza"
Install "sharkdp.bat"
Install "sharkdp.fd"
# Search
Install "BurntSushi.ripgrep.MSVC"
Install "BurntSushi.ripgrep.GNU"
# Diff viewer
Install "dandavison.delta"
# Document converter
Install "JohnMacFarlane.Pandoc"

# ── AI ────────────────────────────────────────────────────────────
Install "GitHub.Copilot"

# ── System & Network ──────────────────────────────────────────────
# System utilities
Install "Microsoft.PowerToys"
# SSH client
Install "PuTTY.PuTTY"
# Cloud storage sync
Install "Rclone.Rclone"
