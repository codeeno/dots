local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- Needed for project.nvim
vim.g.nvim_tree_respect_buf_cwd = 1

vim.cmd [[
  let g:nvim_tree_icons = {
      \ 'default': '',
      \ 'symlink': '',
      \ 'git': {
      \   'unstaged': "✗",
      \   'staged': "✓",
      \   'unmerged': "",
      \   'renamed': "➜",
      \   'untracked': "★",
      \   'deleted': "",
      \   'ignored': "◌"
      \   },
      \ 'folder': {
      \   'arrow_open': "",
      \   'arrow_closed': "",
      \   'default': "",
      \   'open': "",
      \   'empty': "",
      \   'empty_open': "",
      \   'symlink': "",
      \   'symlink_open': "",
      \   }
      \ }
]]

require('nvim-tree').setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "s", cb = tree_cb("vsplit") },
        { key = "t", cb = tree_cb("tabnew") }
      }
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
