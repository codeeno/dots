return {
  {
    "numToStr/Navigator.nvim",
    lazy = true,
    config = function()
      require("Navigator").setup({
        disable_on_zoom = true,
      })
    end,
    keys = {
      { "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n", "t", "v" } },
      { "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n", "t", "v" } },
      { "<C-k>", "<CMD>NavigatorUp<CR>", mode = { "n", "t", "v" } },
      { "<C-j>", "<CMD>NavigatorDown<CR>", mode = { "n", "t", "v" } },
    },
  },
}
