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
      helmfile
      htop
      jq
      just
      kubecolor
      kubectl
      kubectx
      lazydocker
      lazygit
      navi
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
      traceroute
      uv
      wget
      yq
      yt-dlp
      (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-diff
        ];
      })
    ];

    sessionVariables = {
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

    shellAliases = {
      # Utility
      ".." = "cd ..";

      # Shorthands for specific apps
      k = "kubecolor";
      kc = "kubectx";
      ldo = "lazydocker";
      tf = "tofu";
      tg = "terragrunt";
      yz = "yazi";

      # Replacements
      diff = "delta --side-by-side";

      # Misc
      ci = "NO_PROMPT=1 glab ci status | grep '^https' | xargs open";
      weather = "curl wttr.in";
      assume = ". assume";
      sso = ". assume";
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
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh/zsh.nix
  ];
}
