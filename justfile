hostname := shell('h=$(hostname); if [ "$h" = "VAL-028902" ]; then echo macbook; else echo "$h"; fi')
user := shell('whoami')

switch-darwin:
    sudo darwin-rebuild switch --flake .#{{user}}@{{hostname}}
switch-darwin-dry-run:
    sudo darwin-rebuild switch --flake .#{{user}}@{{hostname}} --dry-run

switch-hm:
    home-manager switch --flake .#{{user}}@{{hostname}} --print-build-logs
switch-hm-dry-run:
    home-manager switch --flake .#{{user}}@{{hostname}} --dry-run

update:
    nix flake update
