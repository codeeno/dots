{
  pkgs,
  user,
  host,
  nixPath,
  ...
}:
let
  flakeConfig = "${user}@${host}";
in
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/terminal/claude-code.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";

    packages = with pkgs; [
      openssh
      traceroute
      xsel
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.shellAliases = {
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
  };

  services.ssh-agent.enable = true;
}
