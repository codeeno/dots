{
  pkgs,
  lib,
  user,
  host,
  nixPath,
  ...
}:
let
  flakeConfig = "${user}@${host}";
in
{
  imports = [
    ../../modules/common/terminal
    ../../modules/common/programs/kitty.nix
    ../../modules/common/terminal/claude-code.nix
    #TODO: Re-enable this once llm has been fixed in upstream nixpgks
    # ../../modules/common/terminal/llm.nix

  ];

  fonts.fontconfig.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.05";

    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      talosctl
      traceroute
      rpi-imager
      zstd
      nmap
      discord
    ];
  };

  # See: https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-sudo
  # Run the fetch_nvidia_hash.sh script from the scripts directory, then run sudo /nix/store/<some-path>/bin/non-nixos-gpu-setup
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "580.105.08";
    sha256 = "sha256-2cboGIZy8+t03QTPpp3VhHn6HQFiyMKMjRdiV2MpNHU=";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.shellAliases = {
      hm = "home-manager switch --flake ${nixPath}#${flakeConfig}";
      hmd = "home-manager switch --flake ${nixPath}#${flakeConfig} --dry-run";

      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
  };
}
