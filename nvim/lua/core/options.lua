local options = {
  termguicolors = true,
  mouse = "a",
  swapfile = true,                         -- creates a swapfile
  fileencoding = "utf-8",                  -- the encoding written to a file
  updatetime = 300,                         -- faster completion

  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  expandtab = true,                        -- convert tabs to spaces

  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all horizontal splits to go right of current window

  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- minimal number of screen lines to keep left and right of the cursor

  pumheight = 10,                          -- pop up menu height
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  number = true,                           -- set numbered lines
  cursorline = true,                       -- highlight the current line

  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- override ignorecase if the search pattern contains upper case chars

  }

for k, v in pairs(options) do
  vim.opt[k] = v
end
