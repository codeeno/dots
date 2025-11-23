{
  pkgs,
  ...
}:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "eeno";
    homeDirectory = "/home/eeno";

    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nixd
      nil
      bat
      yazi
      awscli
      btop
      htop
      eza
      fd
      lazygit
      lazydocker
      jq
      kubecolor
      kubectx
      kubectl
      ripgrep
      tldr
      granted
      claude-code
      helm
      helmfile
      opentofu
      terraform
      terragrunt
      uv
      yt-dlp
      ncdu
      go
      zoxide
      glab
      gh
    ];

    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "nvim";
      FCEDIT = "nvim";
      VISUAL = "nvim";
      AWS_PAGER = "";
      AWS_REGION = "eu-central-1";
      TG_TF_PATH = "${pkgs.opentofu}/bin/tofu";
      XDG_CONFIG_HOME = "$HOME/.config";

      #TODO: This should only be applied on darwin
      HOMEBREW_NO_AUTO_UPDATE = "1";

    };

    sessionPath = [
      "$HOME/scripts"
      "$HOME/go/bin"
    ];

    shell = {
      enableShellIntegration = true;
    };
  };

  fonts.fontconfig.enable = true;

  imports = [
    ./home/zsh.nix
    ./home/fzf.nix
    ./home/starship.nix
    ./home/kitty.nix
    ./home/eza
    ./home/git.nix
    ./home/delta.nix
    ./home/k9s
    ./home/ghostty.nix
    ./home/lazyvim
    ./home/tmux.nix
    ./home/mise.nix
    ./home/lazygit.nix
  ];
}
