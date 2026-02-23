{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.k9s;
in
{
  options.modules.cli.tools.k9s = {
    enable = lib.mkEnableOption "k9s kubernetes dashboard";
  };

  config = lib.mkIf cfg.enable {
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
        "shift-1" = {
          shortCut = "Shift-1";
          description = "View pods";
          command = "pods";
        };
        "shift-2" = {
          shortCut = "Shift-2";
          description = "View services";
          command = "services";
        };
        "shift-3" = {
          shortCut = "Shift-3";
          description = "View nodes";
          command = "nodes";
        };
      };
    };
  };
}
