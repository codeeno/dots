{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../modules/common/programs/kitty.nix
    ../../modules/common/services/colima.nix
    ../../modules/common/terminal
    ../../modules/common/terminal/claude-code.nix
    ../../modules/common/terminal/llm.nix
    ../../modules/common/terminal/nvf
    ../../modules/common/terminal/zellij.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";

    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      talosctl
      traceroute
      rpi-imager
      zstd
      nmap
      discord
      xsel
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
    lazyvim.enable = false;

    zsh.shellAliases = {
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
  };
}
