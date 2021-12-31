vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

-- #########################
-- General keybinds
-- #########################

-- Easier write file
map('n', '<Leader>s', ':update<CR>', {noremap = true})

-- Easier buffer navigation
map('n', '<C-h>', '<C-w>h', {noremap = true})
map('n', '<C-l>', '<C-w>l', {noremap = true})
map('n', '<C-j>', '<C-w>j', {noremap = true})
map('n', '<C-k>', '<C-w>k', {noremap = true})

-- Exit insert mode with 'jk'
map('i', 'jk', '<ESC>', {noremap = true})

-- More ergonomic way to scroll up/down fast 
map('n', 'J', '10j', {noremap = true})
map('n', 'K', '10k', {noremap = true})

-- Vertical resize
map('n', '<Leader>,', ':vertical resize +15<CR>', {noremap = true, silent = true})
map('n', '<Leader>.', ':vertical resize -15<CR>', {noremap = true, silent = true})

-- Copy/pase to/from system clipboard
map('', '<Leader>y', '"+y', {noremap = true})
map('', '<Leader>p', '"+p', {noremap = true})

map('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
map('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- #########################
-- Plugin specific keybinds
-- #########################

-- Telescope
map('n', '<Leader>ff', ':Telescope find_files<CR>', {noremap = true, silent = true})
map('n', '<Leader>fg', ':Telescope live_grep<CR>', {noremap = true, silent = true})
map('n', '<Leader>fb', ':Telescope buffers<CR>', {noremap = true, silent = true})

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- nvim-comment
map('n', '<C-_>', ':CommentToggle<CR>', {noremap = true, silent = true})
map('v', '<C-_>', ':CommentToggle<CR>gv', {noremap = true, silent = true})

--map('n', '<leader>2', ':tabNext<CR>', {noremap = true, silent = true})
--map('n', '<leader>1', ':tabprevious<CR>', {noremap = true, silent = true})
--map('n', '<leader>w', ':tabclose<CR>', {noremap = true, silent = true})
--map('v', '<', '<gv', {noremap = true})
--map('v', '>', '>gv', {noremap = true})
