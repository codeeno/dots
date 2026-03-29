# AGENTS.md

This file provides guidance for AI coding agents operating in this repository.

## Project Overview

Personal dotfiles repository using **Nix Flakes** and **Home Manager** to declaratively manage
the user environment across multiple hosts (Linux and macOS via nix-darwin). The primary language
is **Nix**, with **Lua** (Neovim/LazyVim), **Zsh** (shell functions), **KDL** (Zellij),
**YAML** (themes/skins), and **TOML** (stylua config).

There are no traditional build/test/lint pipelines or CI/CD. The "build" is `home-manager switch`.

## Commands

```bash
# Apply Home Manager configuration (primary build/validate command)
just switch-hm              # or: home-manager switch --flake .#<user>@<hostname> --print-build-logs
just switch-hm-dry-run      # dry run: validates Nix evaluation without applying

# Apply nix-darwin system configuration (macOS only)
just switch-darwin

# Nix static analysis
statix check .

# Update flake inputs
nix flake update                           # all inputs
nix flake lock --update-input <input-name> # single input

# Nix store maintenance
just gc        # garbage collect unreachable paths
just optimise  # hard-link duplicate files
```

The `justfile` auto-detects hostname and user. There are **no tests** — validate with
`just switch-hm-dry-run` to check that Nix evaluation succeeds.

## Repository Structure

```
flake.nix                              # Entry point: inputs, outputs, homeConfigurations
justfile                               # Task runner (just)
overlays/default.nix                   # Nixpkgs overlays (zjstatus)
hosts/
  chihiro/home.nix                     # Linux desktop (x86_64-linux)
  macbook/home.nix                     # macOS work laptop (aarch64-darwin)
  macbook/configuration.nix            # nix-darwin system config
  arch-wsl/home.nix                    # WSL (x86_64-linux, minimal)
modules/
  terminal/default.nix                 # Hub: packages, aliases, env vars, imports sub-modules
  terminal/<tool>.nix                  # Individual tool modules (git, fzf, tmux, starship, etc.)
  terminal/<tool>/default.nix          # Tool modules with extra files (eza, k9s, lazyvim, zsh, zellij)
  terminal/lazyvim/lua/                # Neovim config: config/ and plugins/ (Lua)
  terminal/zsh/functions/              # Shell functions: git.zsh, aws.zsh, fzf.zsh
  programs/                            # GUI programs (kitty.nix, ghostty.nix, zed.nix)
  services/                            # Background services (colima.nix)
```

Not all modules are imported by `terminal/default.nix`. Some (claude-code, opencode, llm,
ghostty, zellij) are imported individually per host in `hosts/<hostname>/home.nix`.

## Code Style Guidelines

### Nix Files

**Formatter:** `nixfmt`. 2-space indentation.

**Module pattern:** Every module uses `lib.mkDefault true` for its enable option, making it
active when imported but overridable per-host without `mkForce`. There are no custom options,
no `mkEnableOption`, and no `mkIf` blocks:

```nix
{ lib, ... }:
{
  programs.fzf = {
    enable = lib.mkDefault true;
    # configuration...
  };
}
```

**Function arguments:** Destructured attrset on its own line(s), colon after closing brace.
Use `...` to accept extra args. Alphabetize when there are several args.
For modules needing only `lib`, use single-line: `{ lib, ... }:`

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
```

**Imports:** Use relative paths — `./foo.nix` for files, `./foo` for directories (resolves to
`./foo/default.nix`). All sub-module imports are listed explicitly in the parent `default.nix`.
There is no auto-discovery.

**Package lists:** Use `with pkgs; [ ... ]`, entries alphabetically sorted, one per line:

```nix
home.packages = with pkgs; [
  bat
  fd
  jq
  ripgrep
];
```

**`lib.mkDefault`:** Use for values hosts may override (e.g., git `user.name`, `user.email`).
Omit for universal values.

**String interpolation:** Use `${...}` in `"..."` or `''...''` strings. Reference Nix store
paths for binaries: `"${pkgs.zsh}/bin/zsh"`.

**Comments:** `#` comments sparingly, for non-obvious decisions, workarounds, or TODOs.

### Lua Files (Neovim/LazyVim)

**Formatter:** stylua (2-space indent, 120 column width — see `modules/terminal/lazyvim/lua/stylua.toml`).

Follow LazyVim plugin spec conventions. Return a table from each plugin file. Use `opts` for
plugin configuration, `keys` for keymaps. One plugin (or tightly related group) per file.

### Zsh Functions

Located in `modules/terminal/zsh/functions/`, grouped by domain (git, aws, fzf). Sourced
via Nix store paths in `zsh/default.nix`. Functions use lowercase names, `local` for variables.

### YAML / KDL / TOML

2-space indentation consistently across all config formats.

## Design Patterns

- **Theme:** Tokyo Night across all tools. Catppuccin Macchiato for k9s.
- **Font:** CaskaydiaCove Nerd Font Mono throughout.
- **Keyboard-centric:** Alt-based tmux/zellij bindings, Ctrl-h/j/k/l pane navigation, vi-mode in zsh.
- **XDG compliance:** Configs in `~/.config/` where applicable.
- **Host composition:** Host files import modules they need and add host-specific overrides.

## Host Details

| Host | System | Imports | Notes |
|------|--------|---------|-------|
| `chihiro` | x86_64-linux | terminal, kitty, zellij, claude-code, opencode, llm, colima | NVIDIA GPU, nerd-fonts, xsel |
| `macbook` | aarch64-darwin | terminal, kitty, ghostty, zed, zellij, claude-code, opencode, llm, colima | nix-darwin, work git email |
| `arch-wsl` | x86_64-linux | terminal, claude-code, llm | Minimal, ssh-agent |

## Git Conventions

- **Commit style:** Lowercase, imperative mood, concise. No period at the end.
- Examples: `add opencode home-manager config`, `remove common subdirectory in modules`, `flake update`
- **Branch:** `main` is the default branch.
- **Remote:** `git@github.com:codeeno/dots.git`

## Key Aliases

| Alias | Expands to | Defined in |
|-------|------------|------------|
| `hm` | `home-manager switch --flake .` | zsh module |
| `k` | `kubecolor` | terminal/default.nix |
| `kc` | `kubectx` | terminal/default.nix |
| `tf` | `tofu` | terminal/default.nix |
| `tg` | `terragrunt` | terminal/default.nix |
| `ll` | `eza -la` | zsh module |
| `tree` | `eza --tree` | zsh module |
| `gp` | `git pull` | git module |
| `groot` | `cd $(git rev-parse --show-toplevel)` | git module |
| `ldo` | `lazydocker` | terminal/default.nix |
