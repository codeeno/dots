{
  programs.git = {
    enable = true;
    settings = {
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
      #TODO: How to incluse conditional user settings per host
      user = {
        email = "sebastian@kleboth.de";
        name = "Sebastian Kleboth";
      };
    };
  };
}
