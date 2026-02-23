{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../modules/programs/kitty.nix
    ../../modules/services/colima.nix
    ../../modules/terminal
    ../../modules/terminal/claude-code.nix
    ../../modules/terminal/llm.nix
    ../../modules/terminal/zellij
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

    zsh.shellAliases = {
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
    };
  };
}
