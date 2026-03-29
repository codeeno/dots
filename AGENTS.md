# AGENTS.md

This file provides guidance for AI coding agents operating in this repository.

## Project Overview

Personal dotfiles repository using **Nix Flakes** and **Home Manager** to declaratively manage
the user environment across multiple hosts (Linux and macOS via nix-darwin). The primary language
is **Nix**, with **Lua** (Neovim/LazyVim config), **Zsh** (shell functions), **KDL** (Zellij),
**YAML** (themes/skins), and **TOML** (stylua config).

There are no traditional build/test/lint pipelines or CI/CD. The "build" is `home-manager switch`.

## Commands

```bash
# Apply Home Manager configuration (primary build command)
# Aliased as 'hm' in the user's shell
home-manager switch --flake .#<user>@<hostname> --print-build-logs

# Dry run - preview changes without applying
home-manager switch --flake .#<user>@<hostname> --dry-run

# Apply nix-darwin system configuration (macOS only)
sudo darwin-rebuild switch --flake .#<user>@<hostname>

# Update all flake inputs
nix flake update

# Update a single flake input
nix flake lock --update-input <input-name>

# Garbage collect unreachable store paths
nix store gc --verbose

# Hard-link duplicate files to save space
nix store optimise --verbose
```

### Using the justfile (task runner)

The `justfile` auto-detects `hostname` and `user`:

```bash
just switch-hm           # home-manager switch
just switch-hm-dry-run   # dry run
just switch-darwin        # nix-darwin switch (macOS)
just update               # nix flake update
just gc                   # garbage collect
just optimise             # hard-link dedup
```

### Validation

There are no tests. To validate changes, use `just switch-hm-dry-run` or
`home-manager switch --flake . --dry-run` to check that the Nix evaluation succeeds.
For Nix static analysis, use `statix check .` (statix is available via the Neovim config).

## Repository Structure

```
flake.nix                          # Entry point - flake definition with inputs and outputs
flake.lock                         # Pinned flake input versions
justfile                           # Task runner commands
overlays/default.nix               # Nixpkgs overlays (zjstatus)
hosts/
  chihiro/home.nix                 # Linux desktop (x86_64-linux)
  macbook/home.nix                 # macOS work laptop (aarch64-darwin)
  macbook/configuration.nix        # nix-darwin system config
  arch-wsl/home.nix                # WSL (x86_64-linux, minimal)
modules/
  terminal/default.nix             # Core terminal module (packages, aliases, imports sub-modules)
  terminal/<tool>.nix              # Individual tool modules (git, fzf, tmux, starship, etc.)
  terminal/<tool>/default.nix      # Tool modules with extra files (eza, k9s, lazyvim, zsh, zellij)
  terminal/lazyvim/lua/            # Neovim config: config/ and plugins/ directories (Lua)
  terminal/zsh/functions/          # Shell functions: git.zsh, aws.zsh, fzf.zsh
  programs/                        # GUI programs (kitty, ghostty, zed)
  services/                        # Background services (colima)
wallpapers/                        # Wallpaper images
```

## Code Style Guidelines

### Nix Files

**Formatter:** `nixfmt` (available in the Neovim config). Use 2-space indentation.

**Module pattern:** Every module uses `lib.mkDefault true` for its enable option, making it
active when imported but overridable per-host without `mkForce`:

```nix
{ lib, ... }:
{
  programs.fzf = {
    enable = lib.mkDefault true;
    # ...
  };
}
```

**Function arguments:** Destructured attrset on its own line(s), followed by a colon.
Use `...` to accept extra args. List args alphabetically when there are several:

```nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # module body
}
```

For modules that only need `lib`, use the single-line form: `{ lib, ... }:`

**Imports:** Use relative paths. Prefer `./foo.nix` for files and `./foo` for directories
(which resolve to `./foo/default.nix`). All sub-module imports are listed in the parent
`default.nix` explicitly (no auto-discovery).

**Package lists:** Use `with pkgs; [ ... ]` and keep entries alphabetically sorted, one per line:

```nix
home.packages = with pkgs; [
  bat
  fd
  jq
  ripgrep
];
```

**Settings values:** Use `lib.mkDefault` for values that hosts may need to override (e.g.,
`user.name`, `user.email` in git). Don't use `mkDefault` for values that are universal.

**Comments:** Use `#` comments sparingly. Add them for non-obvious decisions, workarounds,
or TODOs with links to upstream issues.

**String interpolation:** Use `${...}` inside double-quoted strings or `''...''` multiline
strings. Reference Nix store paths for binaries (e.g., `"${pkgs.zsh}/bin/zsh"`).

### Lua Files (Neovim/LazyVim)

**Formatter:** stylua with the following settings (see `modules/terminal/lazyvim/lua/stylua.toml`):
- Indent: 2 spaces
- Column width: 120

**Style:** Follow LazyVim plugin spec conventions. Return a table from each plugin file.
Use `opts` for plugin configuration, `keys` for keymaps. Keep plugin files focused on
a single plugin or tightly related group.

### Zsh Functions

Located in `modules/terminal/zsh/functions/`. Grouped by domain (git, aws, fzf).
Functions use lowercase names with no prefix. Use `local` for variables.

### YAML/KDL/TOML

Use 2-space indentation consistently across all config formats.

## Design Patterns

- **Theme consistency:** Tokyo Night across all tools (starship, fzf, lazygit, tmux, kitty,
  ghostty, zed, btop, zellij, eza). Catppuccin Macchiato for k9s.
- **Font:** CaskaydiaCove Nerd Font Mono throughout.
- **Keyboard-centric:** Alt-based tmux/zellij bindings, Ctrl-h/j/k/l for pane navigation
  (smart-splits/vim-zellij-navigator integration), vi-mode in zsh.
- **XDG compliance:** Configs placed in `~/.config/` where applicable.
- **Host composition:** Host files in `hosts/<hostname>/home.nix` import the modules they need
  and add host-specific overrides (packages, aliases, GPU config, etc.).

## Git Conventions

- **Commit style:** Lowercase, imperative mood, concise. No period at the end.
- Examples: `add opencode home-manager config`, `remove common subdirectory in modules`,
  `add zjstatus`, `flake update`
- **Branch:** `main` is the default branch.
- **Remote:** `git@github.com:codeeno/dots.git`

## Key Aliases and Functions

Defined across modules. Important ones for navigating the system:

| Alias/Function | Expands to | Defined in |
|---------------|------------|------------|
| `hm` | `home-manager switch --flake .` | zsh module |
| `k` | `kubecolor` | terminal/default.nix |
| `kc` | `kubectx` | terminal/default.nix |
| `tf` | `tofu` | terminal/default.nix |
| `tg` | `terragrunt` | terminal/default.nix |
| `ll` | `eza -la` | eza module |
| `tree` | `eza --tree` | eza module |
| `gp` | `git pull` | git module |
| `groot` | `cd $(git rev-parse --show-toplevel)` | git module |

## Hosts

| Host | System | Description |
|------|--------|-------------|
| `chihiro` | x86_64-linux | Linux desktop, all modules, NVIDIA GPU, kitty, zellij |
| `macbook` | aarch64-darwin | macOS work laptop, nix-darwin, kitty, ghostty, zed |
| `arch-wsl` | x86_64-linux | WSL, minimal config |
