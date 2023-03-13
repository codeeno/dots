return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>n",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
  },
  opts = {
    window = {
      mappings = {
        ["o"] = "open_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
      },
    },
  },
}
