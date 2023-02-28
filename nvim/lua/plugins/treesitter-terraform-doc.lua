return {
  "Afourcat/treesitter-terraform-doc.nvim",
  opts = {
    command_name = "OpenDoc",
    url_opener_command = "!open", --MacOS specific opener command. On linux it would be something like !firefox
  },
  keys = {
    { "<leader>fd", ":OpenDoc<CR>", desc = "Open terraform documentation" },
  },
}
