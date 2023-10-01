return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          --ESlint
          nls.builtins.code_actions.eslint_d,
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.formatting.eslint_d,
          -- Terrraform & HCL
          nls.builtins.formatting.terraform_fmt,
          -- Misc
          nls.builtins.diagnostics.hadolint,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.gofmt,
          nls.builtins.formatting.sql_formatter,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.xmlformat,
        },
      }
    end,
  },
}
