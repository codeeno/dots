return {
  "zbirenbaum/copilot.lua",
  opts = {
    copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v20.12.0/bin/node",
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
