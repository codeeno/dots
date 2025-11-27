{ lib, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      # Use mkDefault so hosts can override without mkForce
      user = {
        name = lib.mkDefault "Sebastian Kleboth";
        email = lib.mkDefault "sebastian@kleboth.de";
      };
      alias = {
        co = "checkout";
        st = "status";
        ci = "commit";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
      pull = {
        rebase = false;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.shellAliases = {
    gp = "git pull";
    groot = "cd $(git rev-parse --show-toplevel)";
  };
}
