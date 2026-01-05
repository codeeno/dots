{
  config,
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
      glow
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
      EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      PGHOST = "localhost"; # I dont really know why I need to set this for postgres to work in docker...
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
