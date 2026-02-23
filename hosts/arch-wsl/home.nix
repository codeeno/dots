{
  pkgs,
  user,
  ...
}:
{
  modules = {
    roles = {
      base.enable = true;
      development.enable = true;
      cloud.enable = true;
      work.enable = true;
    };
  };

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
