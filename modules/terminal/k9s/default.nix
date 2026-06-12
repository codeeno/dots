{ lib, ... }:
{
  programs.k9s = {
    enable = lib.mkDefault true;

    settings = {
      k9s = {
        ui = {
          skin = "catppuccin-macchiato";
        };
        logger = {
          tail = 2000;
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
      "shift-4" = {
        shortCut = "Shift-4";
        description = "View secrets";
        command = "secret";
      };
      "shift-5" = {
        shortCut = "Shift-5";
        description = "View PVCs";
        command = "pvc";
      };
    };

    plugins = {
      logs-vim = {
        shortCut = "Shift-V";
        description = "Logs in Vim";
        scopes = [ "po" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          ''"$@" | vim -''
          "dummy-arg"
          "kubectl"
          "logs"
          "$NAME"
          "-n"
          "$NAMESPACE"
          "--context"
          "$CONTEXT"
          "--tail=-1"
        ];
      };

      logs-gonzo = {
        shortCut = "Shift-L";
        description = "Logs in Gonzo";
        scopes = [
          "po"
          "deploy"
          "sts"
          "ds"
          "svc"
          "job"
          "cj"
        ];
        command = "sh";
        background = false;
        args = [
          "-c"
          "kubectl logs -f $RESOURCE_NAME/$NAME -n $NAMESPACE --context $CONTEXT | gonzo"
        ];
      };
    };
  };
}
