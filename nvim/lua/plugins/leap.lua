return {
  "ggandor/leap.nvim",
  keys = {
    { "x", false },
    -- TODO: The below keybindsings don't seem to work, need to figure this out
    { "<leader>j", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    { "<leader>k", mode = { "n", "x", "o" }, desc = "Leap backward to" },
  },
}
