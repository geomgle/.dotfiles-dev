local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end

return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-tree/nvim-web-devicons"
    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {}
      end
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"
    use "p00f/nvim-ts-rainbow"

    -- Color
    use "norcalli/nvim-colorizer.lua"
    use {
      "EdenEast/nightfox.nvim",
      config = function()
        vim.cmd [[colorscheme nightfox]]
      end
    }

    -- LSP
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "neovim/nvim-lspconfig",
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "simrat39/rust-tools.nvim",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "kristijanhusak/vim-dadbod-completion",
        "SirVer/ultisnips"
      }
    }

    -- Edit
    use "tpope/vim-surround"
    use "windwp/nvim-autopairs"
    use "mg979/vim-visual-multi"
    use "terrortylor/nvim-comment"

    -- Format
    use "mhartington/formatter.nvim"
    use "junegunn/vim-easy-align"

    -- Git
    use "tpope/vim-fugitive"
    use "ThePrimeagen/git-worktree.nvim"
    use "chrisbra/changesPlugin"

    -- GnuPG
    use "jamessan/vim-gnupg"

    -- Display
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/bufferline.nvim"
    use "lukas-reineke/indent-blankline.nvim"

    -- Motion
    use "takac/vim-hardtime"
    use "ggandor/lightspeed.nvim"
    use "tpope/vim-repeat"
    use "jessekelighine/vindent.vim"

    -- Navigation
    use "ibhagwan/fzf-lua"
    use "kyazdani42/nvim-tree.lua"
    use "ludovicchabant/vim-gutentags"
    use "airblade/vim-rooter"

    -- Starter
    use "mhinz/vim-startify"

    -- Terminal
    use "akinsho/toggleterm.nvim"
    use "jpalardy/vim-slime"
    use "jabirali/vim-tmux-yank"
    use "christoomey/vim-tmux-navigator"

  end
)
