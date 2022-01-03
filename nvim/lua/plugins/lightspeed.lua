vim.api.nvim_set_keymap('n', '<leader>j', '<Plug>Lightspeed_s', {})
vim.api.nvim_set_keymap('n', '<leader>k', '<Plug>Lightspeed_S', {})

require('lightspeed').setup{}
