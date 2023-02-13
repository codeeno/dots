return {
  "neovim/nvim-lspconfig",
  opts = {
    format = { timeout_ms = 2000 },
    servers = {
      terraformls = {},
      pyright = {},
    },
  },
  setup = {
    tsserver = function(_, opts)
      opts.capabilities.documentFormattingProvider = false
    end,
    terraformls = function(_, opts)
      opts.capabilities.documentFormattingProvider = false
    end,
  },
}
