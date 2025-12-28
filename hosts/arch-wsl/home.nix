{ pkgs, ... }:
let
  flakePath = "~/projects/dots";
  flakeConfig = "eeno@pc";
in
{
  imports = [
    ../../modules/common/terminal
  ];

  home = {
    username = "eeno";
    homeDirectory = "/home/eeno";
    stateVersion = "25.11";

    packages = with pkgs; [ ];
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
}
