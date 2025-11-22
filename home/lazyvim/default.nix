{
  config,
  pkgs,
  lazyvim,
  ...
}:

{
  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;
    configFiles = ./lua;

    extras = {
      lang = {
        nix.enable = true;
        python.enable = true;
        go.enable = true;
        typescript.enable = true;
        lua.enable = true;
        markdown.enable = true;
        helm.enable = true;
        terraform.enable = true;
        toml.enable = true;
        yaml.enable = true;
        docker.enable = true;
      };
    };

    extraPackages = with pkgs; [
      tree-sitter
      statix
      nixfmt
      luarocks
      stylua
    ];
  };
}
