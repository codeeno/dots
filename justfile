# Nix rebuild recipes for all hosts

# macOS - System-level configuration (requires sudo)
dr config="d434547@macbook":
    sudo darwin-rebuild switch --flake .#{{config}}

# macOS - System-level dry-run (requires sudo)
drd config="d434547@macbook":
    sudo darwin-rebuild switch --flake .#{{config}} --dry-run

# User-level home-manager configuration
hm config="d434547@macbook":
    home-manager switch --flake .#{{config}}

# User-level home-manager dry-run
hmd config="d434547@macbook":
    home-manager switch --flake .#{{config}} --dry-run

# NixOS system rebuild (requires sudo)
nixos config="proxmox":
    sudo nixos-rebuild switch --flake .#{{config}}

# Update flake inputs
update:
    nix flake update
