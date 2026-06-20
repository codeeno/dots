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
    ../../modules/terminal/opencode.nix
    ../../modules/programs/ghostty.nix
    ../../modules/terminal/granted.nix
    ../../modules/terminal/llm.nix
    ../../modules/terminal/zellij
    ./scripts
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
      lazysql
      mkcert
      nerd-fonts.caskaydia-cove
      nss
      rancher
      s5cmd
      stu
      trino-cli
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

    git.settings.user.email = "sebastian.kleboth@valiton.com";

    lazygit.settings.services = {
      "gitlab.valiton.com" = "gitlab:gitlab.valiton.com";
      "gitlab.bfops.io" = "gitlab:gitlab.bfops.io";
    };

    # macOS needs explicit shift modifier (M-S-h) instead of uppercase (M-H)
    tmux.extraConfig = lib.mkAfter ''
      bind -n M-S-h previous-window
      bind -n M-S-l next-window

      bind -n M-d split-window -h -c "#{pane_current_path}"
      bind -n M-S-d split-window -v -c "#{pane_current_path}"

    '';

    ssh.settings = {
      "*" = {
        UseKeychain = "yes";
      };
      "gitlab.valiton.com" = {
        Port = 22022;
      };
      "10.0.*.*" = {
        IdentityFile = [ "~/.ssh/id_rsa_home" ];
      };
    };

  };
}
