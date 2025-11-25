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
      nil
      nix-index
      nixd
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
    ./emulators/ghostty.nix
    ./emulators/kitty.nix
    ./programs/btop.nix
    ./programs/delta.nix
    ./programs/eza
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/k9s
    ./programs/lazygit.nix
    ./programs/mise.nix
    ./shell/starship.nix
    ./shell/tmux.nix
    ./shell/zsh.nix
  ];
}
