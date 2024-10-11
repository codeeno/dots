return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "branches" },
  },
  opts = function(_, opts)
    opts.extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    }
  end,
}
