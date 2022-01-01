vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- #########################
-- General keybinds
-- #########################

-- Easier write file
map('n', '<Leader>s', ':update<CR>', {noremap = true})

-- Easier window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)

-- Exit insert mode with 'jk'
map('i', 'jk', '<ESC>', opts)

-- More ergonomic way to scroll up/down fast 
map('n', 'J', '10j', opts)
map('n', 'K', '10k', opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Copy/pase to/from system clipboard
map('', '<Leader>y', '"+y', opts)
map('', '<Leader>p', '"+p', opts)

-- Navigate buffers
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)

-- Stay in visual mode when indenting lines
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- When pasting to replace something, retain what's in the current register
map("v", "p", '"_dP', opts)

-- #########################
-- Plugin specific keybinds
-- #########################

-- Telescope
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<Leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<Leader>fb', ':Telescope buffers<CR>', opts)

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts)

-- nvim-comment
map('n', '<C-_>', ':CommentToggle<CR>', opts)
map('v', '<C-_>', ':CommentToggle<CR>gv', opts)
