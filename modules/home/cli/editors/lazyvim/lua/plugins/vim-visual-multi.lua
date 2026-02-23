return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    vim.g.VM_theme = "purplegray"
    vim.g.VM_maps = {
      --   ["Find Under"] = "<C-n>",
      ["Select Cursor Up"] = "<C-S-k>",
      ["Select Cursor Down"] = "<C-S-j>",
      --
      --   -- buffer mappings
      --   ["Switch Mode"] = "v",
      --   ["Skip Region"] = "q",
      --   ["Remove Region"] = "Q",
      --   ["Goto Next"] = "}",
      --   ["Goto Prev"] = "{",
      --
      --   -- ["Duplicate"] = "<C-q>d",
      --
      --   ["Tools Menu"] = "\\t",
      --   ["Case Conversion Menu"] = "C",
      --   ["Align"] = "\\a",
    }
    -- vim.g.VM_set_statusline = 0 -- already set via lualine component
  end,
}
