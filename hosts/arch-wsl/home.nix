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

    # TODO: retry plain pkgs.opencode once nixpkgs glibc >= 2.43 — this may be fixed.
    # opencode's nix-store glibc loader segfaults under WSL2; the Arch system loader
    # (/lib64) runs the same binary fine, so launch through it. Wrap the cached binary
    # rather than patchelf'ing it — overrideAttrs forces a rebuild whose smoke test
    # hits the same segfault. Hand-written launcher (makeWrapper rejects the runtime-
    # only loader path). See https://github.com/oven-sh/bun/issues/24742
    opencode.package =
      let
        launcher = pkgs.writeShellScript "opencode" ''
          export PATH=${pkgs.ripgrep}/bin:$PATH
          exec /lib64/ld-linux-x86-64.so.2 ${pkgs.opencode}/bin/.opencode-wrapped "$@"
        '';
      in
      pkgs.symlinkJoin {
        name = "opencode-syslinker";
        paths = [ pkgs.opencode ];
        postBuild = ''
          rm -f "$out/bin/opencode"
          ln -s ${launcher} "$out/bin/opencode"
        '';
      };

    zsh.shellAliases = {
      pbcopy = "wl-copy";
      pbpaste = "wl-paste";
    };
  };

  services.ssh-agent.enable = true;
}
