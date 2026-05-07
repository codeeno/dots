{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      ansible
      awscli
      bat
      broot
      dnsutils
      dust
      fd
      gh
      glab
      glow
      go
      htop
      jq
      just
      kubecolor
      kubectl
      kubectx
      lazydocker
      ncdu
      net-tools
      nix-index
      opentofu
      postgresql
      redis
      ripgrep
      terraform-docs
      tflint
      tldr
      uv
      wget
      yamllint
      yamale
      yq
      yt-dlp
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
          helm-git
        ];
      })
    ];

    sessionVariables = {
      AWS_PAGER = "";
      AWS_REGION = "eu-central-1";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      TG_TF_PATH = "${pkgs.opentofu}/bin/tofu";
    };

    sessionPath = [
      "$HOME/go/bin"
    ];

    shell = {
      enableShellIntegration = true;
    };

    shellAliases = {
      # Utility
      ".." = "cd ..";

      # Shorthands for specific apps
      k = "kubecolor";
      kc = "kubectx";
      ldo = "lazydocker";
      tf = "tofu";
      tg = "terragrunt";

      # Misc
      ci = "NO_PROMPT=1 glab ci status | grep '^https' | xargs open";
      weather = "curl wttr.in";

    };
  };

  imports = [
    ./btop.nix
    ./delta.nix
    ./eza
    ./fzf.nix
    ./git.nix
    ./k9s
    ./lazygit.nix
    ./lazyvim
    ./mise.nix
    ./ssh.nix
    ./starship.nix
    ./tmux
    ./yazi.nix
    ./zsh
  ];

  # Disable manual generation to avoid builtins.toFile warning
  # See: https://github.com/nix-community/home-manager/issues/7935
  # TODO: Remove this once issue is resolved
  manual.manpages.enable = false;
}
