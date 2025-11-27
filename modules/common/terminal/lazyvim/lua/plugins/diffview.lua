return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    keys = {
      {
        "<leader>gdm",
        "<cmd>DiffviewOpen main..HEAD<cr>",
        desc = "Open Diffview comparing current branch to main",
      },
    },
  },
}
