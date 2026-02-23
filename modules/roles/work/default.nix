{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.roles.work;
in
{
  options.modules.roles.work = {
    enable = lib.mkEnableOption "AWS tooling and work-specific configuration";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        aws-nuke
        granted
        awscli
      ];

      sessionVariables = {
        AWS_PAGER = "";
        AWS_REGION = "eu-central-1";
        TG_TF_PATH = "${pkgs.opentofu}/bin/tofu";
      };

      shellAliases = {
        assume = ". assume";
        sso = ". assume";
      };
    };
  };
}
