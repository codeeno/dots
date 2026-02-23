{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.roles.cloud;
in
{
  options.modules.roles.cloud = {
    enable = lib.mkEnableOption "AWS, Kubernetes, and IaC tools";
  };

  config = lib.mkIf cfg.enable {
    modules = {
      cli.tools.k9s.enable = true;
    };

    home = {
      packages = with pkgs; [
        ansible
        kubecolor
        kubectl
        kubectx
        lazydocker
        opentofu
        terraform-docs
        tflint
        yamllint
        yamale
        (wrapHelm kubernetes-helm {
          plugins = with pkgs.kubernetes-helmPlugins; [
            helm-diff
            helm-git
          ];
        })
      ];

      shellAliases = {
        k = "kubecolor";
        kc = "kubectx";
        ldo = "lazydocker";
        tf = "tofu";
        tg = "terragrunt";
      };
    };
  };
}
