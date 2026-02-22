{ inputs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {

        globals = {
          mapleader = " ";
        };

        vimAlias = true;

        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
        };

        statusline.lualine.enable = true;

        lsp = {
          enable = true;

          trouble = {
            enable = true;
            mappings = {
              documentDiagnostics = "<leader>xx";
            };
          };
        };

        languages = {
          enableFormat = true;
          enableExtraDiagnostics = true;
          enableTreesitter = true;

          ts.enable = true;
          nix.enable = true;
          yaml.enable = true;
          helm = {
            enable = true;
            lsp.enable = true;
          };
        };

        maps.normal = {
          "<leader>m".action = "<cmd>lua vim.diagnostic.open_float()<CR>"; # Show diagnostics in a floating window
          "<leader>k".action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; # Go to the next diagnostic
          "<leader>jp".action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; # Go to the previous diagnostic
          "<leader>jl".action = "<cmd>lua vim.diagnostic.setloclist()<CR>"; # Set diagnostics in location list
          "<leader>jt".action = "<cmd>Telescope diagnostics<CR>"; # List all diagnostics using Telescope
        };

        binds.whichKey = {
          enable = true;
          setupOpts = {
            preset = "modern";
            notify = true;
            win = {
              border = "rounded";
            };
          };
        };

        ui.borders.plugins.which-key = {
          enable = true;
          style = "rounded";
        };

        utility = {
          surround.enable = true;
        };

        filetree = {
          neo-tree.enable = true;
        };

        keymaps = [
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>Neotree toggle<CR>";
            desc = "Toggle Neotree filesystem show";
          }
        ];
      };
    };
  };
}
