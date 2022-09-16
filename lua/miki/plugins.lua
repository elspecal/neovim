return require "packer".startup(function(use)
  use {
    -- plugin manager
    "wbthomason/packer.nvim",

    -- package manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- language server protocol configuration and completion
    "neovim/nvim-lspconfig",
    {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        {
          "L3MON4D3/LuaSnip",
          requires = { "rafamadriz/friendly-snippets" },
        },
        "onsails/lspkind.nvim",
      },
    },
    "folke/lua-dev.nvim",
    "jose-elias-alvarez/typescript.nvim",

    -- colors
    { "catppuccin/nvim", as = "catppuccin" },
    "folke/tokyonight.nvim",
    "f-person/auto-dark-mode.nvim",

    -- indent lines
    "lukas-reineke/indent-blankline.nvim",

    -- language parser
    {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
    },
    -- speed up startup
    "lewis6991/impatient.nvim",

    -- file tree viewer
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      }
    },

    -- fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      requires = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        "kyazdani42/nvim-web-devicons",
      }
    },

    -- auto-complete pair-wise symbols
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
  }
end)
