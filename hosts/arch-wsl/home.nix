{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../modules/terminal
    ../../modules/terminal/opencode.nix
    ../../modules/terminal/claude-code.nix
    ../../modules/terminal/llm.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";

    packages = with pkgs; [
      argocd
      gnumake
      openssh
      traceroute
      wl-clipboard
      xsel
    ];

    # WSLg exposes its Wayland socket at /mnt/wslg/runtime-dir/wayland-0,
    # but WAYLAND_DISPLAY=wayland-0 makes clients look in $XDG_RUNTIME_DIR.
    # Symlink the socket so wl-copy/wl-paste (used by Neovim) can connect.
    activation.linkWslgWaylandSocket = ''
      run mkdir -p "/run/user/$(id -u)"
      run ln -sf /mnt/wslg/runtime-dir/wayland-0 "/run/user/$(id -u)/wayland-0"
      run ln -sf /mnt/wslg/runtime-dir/wayland-0.lock "/run/user/$(id -u)/wayland-0.lock"
    '';
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh.shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
    };
  };

  services.ssh-agent.enable = true;
}
