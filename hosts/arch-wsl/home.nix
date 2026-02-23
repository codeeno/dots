{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../modules/terminal
    ../../modules/terminal/claude-code.nix
    ../../modules/terminal/llm.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";

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
