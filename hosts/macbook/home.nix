{
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ../../modules/programs/kitty.nix
    ../../modules/programs/zed.nix
    ../../modules/services/colima.nix
    ../../modules/terminal
    ../../modules/terminal/claude-code.nix
    ../../modules/terminal/ghostty.nix
    ../../modules/terminal/llm.nix
    ../../modules/terminal/zellij
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = user;
    homeDirectory = "/Users/${user}";
    stateVersion = "26.05";

    sessionPath = [
      "$HOME/scripts"
    ];

    packages = with pkgs; [
      aws-nuke
      clickhouse
      crossplane-cli
      github-copilot-cli
      granted
      lazysql
      mkcert
      nerd-fonts.caskaydia-cove
      nss
      rancher
      s5cmd
      stu
    ];

    shellAliases = {
      oc = "opencode";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    kitty.settings = {
      kitty_mod = "cmd";
      font_size = 14;
    };

    # Override default email for work machine
    git.settings.user.email = "sebastian.kleboth@valiton.com";

    # macOS needs explicit shift modifier (M-S-h) instead of uppercase (M-H)
    tmux.extraConfig = lib.mkAfter ''
      bind -n M-S-h previous-window
      bind -n M-S-l next-window

      bind -n M-d split-window -h -c "#{pane_current_path}"
      bind -n M-S-d split-window -v -c "#{pane_current_path}"

    '';

    ssh.matchBlocks = {
      "*" = {
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      "gitlab.valiton.com" = {
        port = 22022;
      };
      "10.0.*.*" = {
        identityFile = [ "~/.ssh/id_rsa_home" ];
      };
    };

  };
}
