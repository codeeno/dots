{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.roles.base;
in
{
  options.modules.roles.base = {
    enable = lib.mkEnableOption "Base packages for all hosts";
  };

  config = lib.mkIf cfg.enable {
    modules = {
      system.nix.enable = true;
      cli = {
        shells.zsh.enable = true;
        ai.claude-code.enable = true;
        ai.llm.enable = true;
        tools.starship.enable = true;
        tools.fzf.enable = true;
        tools.eza.enable = true;
        tools.btop.enable = true;
        tools.ssh.enable = true;
        tools.yazi.enable = true;
        multiplexers.tmux.enable = true;
        multiplexers.zellij.enable = true;
      };
    };

    home = {
      packages = with pkgs; [
        bat
        broot
        dnsutils
        dust
        fd
        htop
        jq
        just
        ncdu
        net-tools
        nix-index
        ripgrep
        tldr
        wget
        yq
        yt-dlp
        zoxide
      ];

      sessionVariables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };

      shell = {
        enableShellIntegration = true;
      };

      shellAliases = {
        ".." = "cd ..";
        weather = "curl wttr.in";
      };
    };
  };
}
