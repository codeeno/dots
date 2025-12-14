{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;
    configFiles = ./lua;

    extras = {

      lang = {
        docker.enable = true;
        git.enable = true;
        go.enable = true;
        helm.enable = true;
        json.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        python.enable = true;
        scala.enable = true;
        tailwind.enable = true;
        terraform.enable = true;
        toml.enable = true;
        typescript.enable = true;
        yaml.enable = true;
      };

      coding = {
        yanky.enable = true;
        luasnip.enable = true;
      };

      formatting = {
        prettier.enable = true;
      };

      linting = {
        eslint.enable = true;
      };

      editor = {
        inc_rename.enable = true;
        mini_diff.enable = true;
      };

      ai = {
        # TODO: Switch to copilot_native once nvim 0.12 is released
        copilot.enable = true;
        copilot_chat.enable = true;
      };

      test = {
        core.enable = true;
      };

      util = {
        dot.enable = true;
      };
    };

    extraPackages = with pkgs; [
      # Treesitter
      tree-sitter

      # Formatters
      gofumpt # Go
      nixfmt # Nix
      prettier
      prettierd # JS/TS/CSS/HTML/JSON/Markdown
      shfmt # Shell
      stylua # Lua

      # Linters
      markdownlint-cli2 # Markdown
      ruff # Python (linter + formatter)
      statix # Nix

      # Language servers
      bash-language-server
      docker-compose-language-service
      dockerfile-language-server
      gopls # Go
      helm-ls
      lua-language-server
      marksman # Markdown
      nil
      nixd
      pyright # Python
      tailwindcss-language-server
      taplo # TOML
      terraform-ls
      tofu-ls
      tflint
      vscode-langservers-extracted
      vtsls # TypeScript/JavaScript
      yaml-language-server

      # Build tools / misc
      fish # includes fish_indent formatter
      gotools # includes goimports
      luarocks # Lua package manager
      packer # HashiCorp Packer (packer_fmt)
    ];
  };

  home.shellAliases = {
    vim = "nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    FCEDIT = "nvim";
    VISUAL = "nvim";
  };
}
