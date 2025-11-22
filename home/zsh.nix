{ config, ... }:

{
  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Aliases
      lg = "lazygit";
      ldocker = "lazydocker";
      tg = "terragrunt";
      tf = "tofu";
      k = "kubecolor";
      kc = "kubectx";
      assume = ". assume";
      sso = ". assume";
      yz = "yazi";
      hm = "home-manager switch --flake .";

      # Replacements
      vim = "nvim";
      diff = "delta --side-by-side";

      # Eza
      ll = "eza --long --header --git --all";
      tree = "eza --tree --long --git --header --git-ignore";

      # Git related
      ci = "NO_PROMPT=1 glab ci status | grep '^https' | xargs open";
      groot = "cd $(git rev-parse --show-toplevel)";

      # Misc
      weather = "curl wttr.in";
    };
  };
}
