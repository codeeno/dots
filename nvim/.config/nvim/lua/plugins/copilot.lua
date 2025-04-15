return {
  "zbirenbaum/copilot.lua",
  opts = {
    filetypes = {
      yaml = true, -- overrides default
    },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
        next = "<C-]>",
        prev = "<C-[>",
      },
    },
  },
}
