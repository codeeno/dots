{
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      ansible
      awscli
      bat
      broot
      claude-code
      dust
      fd
      gh
      glab
      go
      granted
      helmfile
      htop
      jq
      kubecolor
      kubectl
      kubectx
      lazydocker
      lazygit
      navi
      ncdu
      nerd-fonts.caskaydia-cove
      nix-index
      opentofu
      postgresql
      redis
      ripgrep
      s5cmd
      stu
      terraform
      terragrunt
      tldr
      uv
      wget
      yazi
      yq
      yt-dlp
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
        ];
      })
    ];

    sessionVariables = {
      EDITOR = "nvim";
      FCEDIT = "nvim";
      VISUAL = "nvim";
      AWS_PAGER = "";
      AWS_REGION = "eu-central-1";
      TG_TF_PATH = "${pkgs.opentofu}/bin/tofu";
    };

    sessionPath = [
      "$HOME/go/bin"
    ];

    shell = {
      enableShellIntegration = true;
    };
  };

  imports = [
    ./btop.nix
    ./delta.nix
    ./eza/eza.nix
    ./fzf.nix
    ./git.nix
    ./k9s/k9s.nix
    ./lazygit.nix
    ./lazyvim/lazyvim.nix
    ./mise.nix
    ./starship.nix
    ./tmux.nix
    ./zsh/zsh.nix
  ];
}
