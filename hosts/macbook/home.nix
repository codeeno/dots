{ pkgs, lib, ... }:
let
  flakePath = "~/projects/personal/dots";
  flakeConfig = "d434547@macbook";
in
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/programs/kitty.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "d434547";
    homeDirectory = "/Users/d434547";
    stateVersion = "25.05";

    sessionPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "$HOME/scripts"
    ];

    packages = with pkgs; [
      crossplane-cli
      granted
      nerd-fonts.caskaydia-cove
      opencode
      s5cmd
      stu
    ];

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

    zsh.shellAliases = {
      dr = "sudo darwin-rebuild switch --flake ${flakePath}#${flakeConfig}";
      drd = "sudo darwin-rebuild switch --flake ${flakePath}#${flakeConfig} --dry-run";
      hm = "home-manager switch --flake ${flakePath}#${flakeConfig}";
      hmd = "home-manager switch --flake ${flakePath}#${flakeConfig} --dry-run";
    };

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
    };

  };
}
