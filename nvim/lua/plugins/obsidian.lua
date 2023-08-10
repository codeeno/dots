return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/Notes/obsidian-notes/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/Notes/obsidian-notes", -- no need to call 'vim.fn.expand' here
  },
}
