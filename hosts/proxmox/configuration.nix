{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan
    # Generate this on the target machine with:
    # sudo nixos-generate-config --show-hardware-config > ~/dots/hosts/mini-pc/hardware-configuration.nix
    # ./hardware-configuration.nix
  ];

  # Enable QEMU Guest for Proxmox
  services.qemuGuest.enable = lib.mkDefault true;

  # Use the boot drive for grub
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.devices = [ "nodev" ];

  boot.growPartition = lib.mkDefault true;

  # Networking
  networking.hostName = "mini-pc";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;

  # Allow remote updates with flakes and non-root users
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Don't ask for passwords
  security.sudo.wheelNeedsPassword = false;

  # User account
  users.users.eeno = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDtuHHlUdMU+QO7Lerms2Ki3QJfjn7zK69pDo/sHLura67UtLiByBig0SwAp7vND7bm4Njy0N+AWQwJDIP0v5Ni5h6OTho7KYcDbuurjemEnCqND2FaSOvNBCK0694QD/oCoFfPBRxe1416y3UGdtcOyOMhLzn874VrPOq4M7j5Xp+pGFYKTdNbDMktCElKKGnI/KtxyVgawm3Pe2lx4hQ8OV4p/GkCmKO5YIRPhOfMOMf8tG5UELzkFihsSl55WbEPA/ap8VIkjdYRqui8YK4l6ROSHM8M3jIucnk/EFAb15yIsUeYOhBlpuFadgiU1DRqUuEixGmWIY8LdcyX2a0bmGioQzE5ex6imgMidLipCyf+XrmFSkcPL79/T+w265IjYaSL3B3pF2Iphfq/Cx9bF29RN8pprNqpQbZrB5Wtp/AuTphPB7Q0/4S1fptPlt1lahoMquj5BEkniuyyOkKx9cb7xrH4UVnk8gbhrVUssj4THHC7uH/PmM8tXvg8NO8= ansible-generated on akira"
    ];
  };

  # Enable ssh
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  programs.ssh.startAgent = true;

  # Default filesystem
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05";
}
