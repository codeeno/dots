return {
  "akinsho/toggleterm.nvim",
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = 80,
    open_mapping = [[<C-e>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "vertical", -- Possible: 'vertical' | 'horizontal' | 'tab' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
  },
  keys = {
    { "<C-e>", [[<Cmd>ToggleTerm<CR>]], mode = "n" },
    { "<C-e>", [[<Cmd>ToggleTerm<CR>]], mode = "i" },
    { "<C-e>", [[<Cmd>ToggleTerm<CR>]], mode = "t" },
    { "<C-w>", [[<Cmd>ToggleTerm<CR>]], mode = "t" },
    { "<C-h>", [[<Cmd>wincmd h<CR>]], mode = "t" },
    { "<C-j>", [[<Cmd>wincmd j<CR>]], mode = "t" },
    { "<C-k>", [[<Cmd>wincmd k<CR>]], mode = "t" },
    { "<C-l>", [[<Cmd>wincmd l<CR>]], mode = "t" },
  },
}
