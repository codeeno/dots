return require('packer').startup(function()
    use {
      'wbthomason/packer.nvim'
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {{'kyazdani42/nvim-web-devicons'}}
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
      "terrortylor/nvim-comment"
    }
    use {
      'neovim/nvim-lspconfig'
    }


    -- Colorschemes
    use {
      'folke/tokyonight.nvim'
    }
    use {
      "catppuccin/nvim",
      as = "catppuccin"
    }
    use {
      'bluz71/vim-nightfly-guicolors'
    }
    
    
end)
