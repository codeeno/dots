require('core.options')
require('core.plugins')
require('core.keybinds')

require ('lsp.language-servers')
require ('lsp.cmp')
require ('lsp.null-ls')
require ('lsp.diagnostics')

require('plugins.treesitter')
require('plugins.telescope')
require('plugins.bufferline')
require('plugins.nvim-tree')
require('plugins.lualine')
require('plugins.comment')
require('plugins.autopairs')
require('plugins.surround')
require('plugins.toggleterm')
require('plugins.project')
require('plugins.alpha')
require('plugins.indent-blankline')
require('plugins.gitsigns')
require('plugins.lightspeed')
require('plugins.presence')

require('plugins.catppuccin')
require('plugins.tokyonight')

vim.cmd[[colorscheme tokyonight]]
