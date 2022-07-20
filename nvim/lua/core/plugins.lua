
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function()
    -- Plugin Management
    use { 'wbthomason/packer.nvim' }

    -- LSP
    use { 'jose-elias-alvarez/null-ls.nvim', requires = {{'nvim-lua/plenary.nvim'}} }
    use { 
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer'
    }

    -- Code completion (cmp)
    use {
      'hrsh7th/nvim-cmp',          -- the main plugin
      'hrsh7th/cmp-nvim-lsp',      -- lsp completions
      'saadparwaiz1/cmp_luasnip',  -- snippet completions
      'hrsh7th/cmp-buffer',        -- buffer completions
      'hrsh7th/cmp-path',          -- path completions
      'hrsh7th/cmp-cmdline',       -- cmdline completions
      'onsails/lspkind-nvim'       -- devicons for completion window 
    }

    -- Snippets
    use {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets"
    }

    -- Syntax highlighting
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use { "p00f/nvim-ts-rainbow" }
    use { "lukas-reineke/indent-blankline.nvim" }

    -- File navigation
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}} }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'kyazdani42/nvim-tree.lua', requires = {{'kyazdani42/nvim-web-devicons'}} }
    
    -- Editing related plugins
    use { "windwp/nvim-autopairs" }
    use { "terrortylor/nvim-comment" }
    use { "kylechui/nvim-surround" }

    -- Bufferline, Lualine
    use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
    use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
   
    -- Colorschemes
    use { 'folke/tokyonight.nvim' }
    use { "catppuccin/nvim", as = "catppuccin"}
    use { 'bluz71/vim-nightfly-guicolors' }
    use { 'projekt0n/github-nvim-theme' }

    -- Motion
    use { 'ggandor/lightspeed.nvim' }

    -- Misc
    use { "akinsho/toggleterm.nvim" }
    use { "ahmedkhalf/project.nvim" }
    use { "goolord/alpha-nvim" }
    use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use { 'andweeb/presence.nvim' }
    use { 'mg979/vim-visual-multi' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
