{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    # You'll need to generate this on the target machine with:
    # sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
    # ./hardware-configuration.nix
  ];

  # # Bootloader
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  #
  # # Networking
  # networking.hostName = "mini-pc";
  # networking.networkmanager.enable = true;
  #
  # # Time zone
  # time.timeZone = "Europe/Berlin";
  #
  # # Internationalization
  # i18n.defaultLocale = "en_US.UTF-8";
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "de_DE.UTF-8";
  #   LC_IDENTIFICATION = "de_DE.UTF-8";
  #   LC_MEASUREMENT = "de_DE.UTF-8";
  #   LC_MONETARY = "de_DE.UTF-8";
  #   LC_NAME = "de_DE.UTF-8";
  #   LC_NUMERIC = "de_DE.UTF-8";
  #   LC_PAPER = "de_DE.UTF-8";
  #   LC_TELEPHONE = "de_DE.UTF-8";
  #   LC_TIME = "de_DE.UTF-8";
  # };

  # User account
  users.users.eeno = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # # System packages (keep minimal, prefer home-manager for user packages)
  # environment.systemPackages = with pkgs; [
  #   vim
  #   git
  #   wget
  #   curl
  # ];

  # Enable SSH
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # system.stateVersion = "24.11";
}
