-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

-- #########################
-- General keybinds
-- #########################

-- Easier write file
vim.keymap.set("n", "<Leader>w", ":update<CR>", opts)

-- Exit insert mode with 'jk'
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Stay in visual mode when indenting lines
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Close current buffer
vim.keymap.set("n", "<C-q>", ":bp|bd #<CR>", opts)

-- When pasting to replace something, retain what's in the current register
vim.keymap.set("v", "p", '"_dP', opts)
