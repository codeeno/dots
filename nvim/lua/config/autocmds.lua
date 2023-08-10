-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.lua",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-c>", ":luafile %<CR>", { silent = false })
  end,
})
