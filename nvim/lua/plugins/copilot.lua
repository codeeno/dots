return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
        next = "<C-]>",
        prev = "<C-[>",
      },
    },
    filetypes = {
      yaml = true,
    },
  },
}
