hostname := shell('hostname')
user := shell('whoami')

switch-darwin:
    sudo darwin-rebuild switch --flake .#{{user}}@{{hostname}}
switch-darwin-dry-run:
    sudo darwin-rebuild switch --flake .#{{user}}@{{hostname}} --dry-run

switch-hm:
    home-manager switch --flake .#{{user}}@{{hostname}}
switch-hm-dry-run:
    home-manager switch --flake .#{{user}}@{{hostname}} --dry-run

update:
    nix flake update
