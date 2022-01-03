local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local code_acionts = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  diagnostics.eslint,
}

null_ls.setup({
    sources = sources,

    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
      end
    end
})
