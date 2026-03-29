return {
  "neovim/nvim-lspconfig",
  opts = {
    format = { timeout_ms = 2000 },
    servers = {
      lua_ls = {
        root_markers = { ".git" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
      tailwindcss = {},
      terraformls = { enabled = false },
      tofu_ls = { enabled = true },
      pyright = {},
      tsserver = {
        settings = {
          diagnostics = {
            enable = true,
            -- disable some diagnostics
            ignoredCodes = {
              6133, -- XXX is declared but its value is never read (duplicate with eslint)
              7016, -- Could not find declaration file
            },
          },
        },
      },
    },
  },
  setup = {
    tsserver = function(_, opts)
      opts.capabilities.documentFormattingProvider = false -- disable formatting since we use eslint_d
    end,
    terraformls = function(_, opts)
      opts.capabilities.documentFormattingProvider = false
    end,
  },
}
