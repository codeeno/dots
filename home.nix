{
  pkgs,
  ...
}:

{
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "eeno";
    homeDirectory = "/home/eeno";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nerd-fonts.caskaydia-cove
    pkgs.nixd
    pkgs.nil
    pkgs.bat
    pkgs.yazi
    pkgs.awscli
    pkgs.btop
    pkgs.htop
    pkgs.eza
    pkgs.fd
    pkgs.lazygit
    pkgs.lazydocker
    pkgs.jq
    pkgs.kubecolor
    pkgs.kubectx
    pkgs.kubectl
    pkgs.ncdu
    pkgs.ripgrep
    pkgs.tldr
    pkgs.uv
    pkgs.yt-dlp
    pkgs.granted
    pkgs.claude-code
    pkgs.helm
    pkgs.helmfile
    pkgs.opentofu
    pkgs.terraform
    pkgs.terragrunt
    pkgs.uv
    pkgs.yt-dlp
    pkgs.tldr
    pkgs.ncdu
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eeno/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.shell = {
    enableShellIntegration = true;
  };

  programs.zoxide.enable = true;

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
