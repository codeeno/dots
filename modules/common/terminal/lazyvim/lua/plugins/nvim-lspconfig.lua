return {
  "neovim/nvim-lspconfig",
  opts = {
    format = { timeout_ms = 2000 },
    servers = {
      tailwindcss = {},
      terraformls = {},
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
