{
  programs.k9s = {
    enable = true;

    settings = {
      k9s = {
        ui = {
          skin = "catppuccin-macchiato";
        };
        logger = {
          tail = 500;
          buffer = 50000;
          sinceSeconds = -1;
        };
      };
    };

    skins = {
      catppuccin-macchiato = ./skins/catppuccin-macchiato.yaml;
    };

    aliases = {
      dp = "deployments";
      sec = "v1/secrets";
      jo = "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies";
    };

    hotKeys = {
      "shift-0" = {
        shortCut = "Shift-0";
        description = "View pods";
        command = "po";
      };
      "shift-1" = {
        shortCut = "Shift-1";
        description = "View deployments";
        command = "dp";
      };
      "shift-2" = {
        shortCut = "Shift-2";
        description = "View nodes";
        command = "nodes";
      };
    };
  };
}
