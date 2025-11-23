# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository using **Nix Flakes** and **Home Manager** to declaratively manage the user environment for user "eeno" on NixOS/Linux.

## Key Commands

```bash
# Apply configuration changes (aliased as 'hm' in zsh)
home-manager switch --flake .

# Update all flake inputs
nix flake update

# Update a specific input
nix flake lock --update-input nixpkgs

# Preview changes without applying
home-manager switch --flake . --dry-run
```

## Architecture

### Entry Points
- `flake.nix` - Nix Flake definition with inputs (nixpkgs, home-manager, lazyvim) and outputs
- `home.nix` - Main Home Manager configuration that imports all modules and defines global packages

### Module Structure
Each program has its own module in `home/`:
- `zsh.nix` - Shell config with aliases and custom AWS/git functions
- `tmux.nix` - Terminal multiplexer with Alt-based keybindings and tokyo-night theme
- `kitty.nix` - Terminal emulator (multiplexing delegated to tmux)
- `starship.nix` - Prompt with Tokyo Night palette and kubernetes context detection
- `git.nix` - Git config (user: Sebastian Kleboth, zdiff3 conflicts, default branch: main)
- `delta.nix` - Diff viewer with line numbers and decorations
- `fzf.nix` - Fuzzy finder with Tokyo Night colors
- `lazygit.nix` - Git TUI with delta integration
- `mise.nix` - Version manager config
- `eza/` - Modern ls replacement with Tokyo Night theme
- `k9s/` - Kubernetes dashboard with Catppuccin Macchiato skin
- `lazyvim/` - Neovim configuration with `default.nix` wrapper and `lua/` configs

### Key Aliases (zsh.nix)
- `k` = kubecolor, `kc` = kubectx, `tf` = tofu, `tg` = terragrunt
- `yz` = yazi, `ldo` = lazydocker, `hm` = home-manager switch
- `ll` = eza long format, `tree` = eza tree view
- `assume`/`sso` = AWS role assumption

### Custom Functions (zsh.nix)
- `param()` - Fetch AWS SSM parameters with FZF
- `secret()` - Retrieve AWS Secrets Manager secrets
- `logs()` - Tail CloudWatch logs
- `fgb()`/`fgc()` - FZF git branch browser/checkout
- `gopen()` - Open current git repo in browser

### Design Patterns
- **Theme consistency**: Tokyo Night across starship, fzf, lazygit, tmux, kitty, eza; Catppuccin Macchiato for k9s and Neovim
- **Font**: CaskaydiaCove Nerd Font Mono throughout
- **XDG compliance**: Configs placed in `~/.config/` where applicable
- **Keyboard-centric**: Alt-based tmux bindings, vim-style editors, Ctrl-h/j/k/l navigation

### Tool Stack
- **Terminal**: Kitty + tmux + Zsh + Starship
- **Editor**: Neovim via lazyvim-nix wrapper (LazyVim extras: Nix, Python, Go, TypeScript, Terraform, Helm, Docker)
- **Version management**: mise (Node LTS, Python 3.12, Rust, OpenTofu 1.8.6, Terragrunt 0.83.2)
- **Kubernetes**: k9s, kubectl, kubecolor, kubectx, lazydocker
- **Git**: lazygit, delta, gitlinker (GitLab URLs), diffview
- **Cloud**: awscli, granted (role assumption), helm, helmfile, opentofu, terragrunt
- **Utilities**: bat, yazi, eza, fd, ripgrep, jq, zoxide, btop
