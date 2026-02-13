{
  pkgs,
  ...
}:
let
  commonSettings = {
    cpu = 4;
    disk = 80;
    memory = 12;
    forwardAgent = true;
    runtime = "docker";
    dnsHosts = {
      "host.docker.internal" = "host.lima.internal";
    };
    vmType = if pkgs.stdenv.isDarwin then "vz" else "qemu";
    rosetta = if pkgs.stdenv.isDarwin then true else false;
  };
in
{
  services.colima = {
    enable = true;
    profiles = {
      docker = {
        isActive = true;
        settings = commonSettings;
      };
      k8s = {
        settings = commonSettings // {
          cpu = 8;
          runtime = "containerd";
          kubernetes = {
            enabled = true;
            version = "v1.33.3+k3s1";
            k3sArgs = [ "--disable=traefik" ];
          };
        };
      };
    };
  };

  programs.zsh.sessionVariables = {
    /*
      Colima likes to overwrite the config file when activating a profile using 'colima start <profile>'.
      This interferes with the symlinked files from Nix, therefore we disable the overwrite using this environment variable.
    */
    COLIMA_SAVE_CONFIG = 0;
  };

  home.packages = with pkgs; [
    docker
  ];
}
