{
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
      # Treesitter
      tree-sitter

      # Formatters
      gofumpt # Go
      nixfmt # Nix
      prettier # JS/TS/CSS/HTML/JSON/Markdown
      shfmt # Shell
      stylua # Lua

      # Linters
      markdownlint-cli2 # Markdown
      ruff # Python (linter + formatter)
      statix # Nix

      # Language servers
      dockerfile-language-server-nodejs
      docker-compose-language-service
      gopls # Go
      helm-ls
      lua-language-server
      marksman # Markdown
      pyright # Python
      tailwindcss-language-server
      taplo # TOML
      terraform-ls
      vtsls # TypeScript/JavaScript
      yaml-language-server

      # Build tools / misc
      fish # includes fish_indent formatter
      gotools # includes goimports
      luarocks # Lua package manager
      packer # HashiCorp Packer (packer_fmt)
    ];
  };
}
