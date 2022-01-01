require('core.options')
require('core.plugins')
require('core.keybinds')
require('plugins.cmp')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.bufferline')
require('plugins.nvim-tree')
require('plugins.nvim-lualine')
require('plugins.nvim-comment')
require('plugins.nvim-autopairs')

require('lsp')

require('plugins.catppuccin')
require('plugins.tokyonight')

vim.cmd[[colorscheme tokyonight]]
