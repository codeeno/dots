return {
  "ruifm/gitlinker.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("gitlinker").setup({
      callbacks = {
        ["gitlab.bfops.io"] = require("gitlinker.hosts").get_gitlab_type_url,
        ["gitlab.valiton.com"] = require("gitlinker.hosts").get_gitlab_type_url,
      },
    })
  end,
  opts = {
    mappings = nil,
  },
  keys = {
    {
      "<leader>gy",
      function()
        require("gitlinker").get_repo_url()
      end,
      desc = "Copy URL for current line in file",
    },
    {
      "<leader>gO",
      function()
        require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
      end,
      desc = "Open URL for current repo",
    },
    {
      "<leader>go",
      function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end,
      desc = "Open URL for current line in file",
    },
  },
}
