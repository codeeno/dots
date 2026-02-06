{
  pkgs,
  lib,
  user,
  ...
}:
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/programs/kitty.nix
    ../../modules/common/programs/zed.nix
    ../../modules/common/terminal/claude-code.nix
    ../../modules/common/terminal/ghostty.nix
    ../../modules/common/terminal/llm.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = user;
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";

    sessionPath = [
      "$HOME/scripts"
    ];

    packages = with pkgs; [
      clickhouse
      crossplane-cli
      github-copilot-cli
      granted
      lazysql
      mkcert
      nerd-fonts.caskaydia-cove
      nss
      opencode
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
      macos_option_as_alt = "yes";
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
