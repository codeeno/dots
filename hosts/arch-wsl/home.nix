{ pkgs, ... }:
let
  flakePath = "~/dots";
  flakeConfig = "eeno@arch-wsl";
in
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/terminal/claude-code.nix
  ];

  home = {
    username = "eeno";
    homeDirectory = "/home/eeno";
    stateVersion = "25.11";

    packages = with pkgs; [
      openssh
      xsel
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.shellAliases = {
      hm = "home-manager switch --flake ${flakePath}#${flakeConfig}";
      hmd = "home-manager switch --flake ${flakePath}#${flakeConfig} --dry-run";

      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
  };

  services.ssh-agent.enable = true;
}
