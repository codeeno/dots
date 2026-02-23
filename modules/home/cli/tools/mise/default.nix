{ config, lib, ... }:
let
  cfg = config.modules.cli.tools.mise;
in
{
  options.modules.cli.tools.mise = {
    enable = lib.mkEnableOption "mise version manager";
  };

  config = lib.mkIf cfg.enable {
    programs.mise = {
      enable = true;
      globalConfig = {
        tools = {
          node = "lts";
          opentofu = "1.8.6";
          python = "3.12";
          rust = "latest";
          terragrunt = "0.83.2";
        };
        settings = {
          idiomatic_version_file_enable_tools = [
            "node"
            "terraform"
            "python-version"
            "go-version"
          ];
          python.uv_venv_auto = true;
          experimental = true;
        };
      };
    };
  };
}
