{ inputs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        vimAlias = true;

        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
        };

        statusline.lualine.enable = true;

        lsp = {
          enable = true;
        };

        languages = {
          enableTreesitter = true;

          ts.enable = true;
          nix.enable = true;
        };
      };
    };
  };
}
