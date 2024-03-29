return require("packer").startup({
	function(use)
		use({
			-- plugin manager
			"wbthomason/packer.nvim",

			-- package manager
			{
				"williamboman/mason.nvim",
				config = "require 'miki.configs.mason'",
			},
			{
				"williamboman/mason-lspconfig.nvim",
				after = "mason.nvim",
				config = "require 'miki.configs.mason-lspconf'",
			},
			{
				"jayp0521/mason-null-ls.nvim",
				config = "require 'miki.configs.mason-null-ls'",
				after = "null-ls.nvim",
			},

			-- language server protocol configuration and completion
			{
				"neovim/nvim-lspconfig",
				after = "mason-null-ls.nvim",
				config = "require 'miki.configs.lsp'",
			},
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
			"folke/neodev.nvim",
			"jose-elias-alvarez/typescript.nvim",
			{
				"jose-elias-alvarez/null-ls.nvim",
				after = "mason.nvim",
				config = "require 'miki.configs.null-ls'",
			},
			{
				"glepnir/lspsaga.nvim",
				branch = "main",
			},
			-- colors
			{ "catppuccin/nvim", as = "catppuccin" },
			"folke/tokyonight.nvim",
			"EdenEast/nightfox.nvim",
			"f-person/auto-dark-mode.nvim",
			"rebelot/kanagawa.nvim",
			"sainnhe/everforest",

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
					"nvim-tree/nvim-web-devicons",
					"MunifTanjim/nui.nvim",
				},
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
						run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
					},
					"nvim-tree/nvim-web-devicons",
				},
			},

			-- auto-complete pair-wise symbols
			"windwp/nvim-autopairs",
			"windwp/nvim-ts-autotag",

			-- manage multiple terminal windows
			{
				"akinsho/toggleterm.nvim",
				tag = "*",
				config = function()
					require("toggleterm").setup()
				end,
			},

			-- JSON schemas
			"b0o/schemastore.nvim",

			-- git integration
			"lewis6991/gitsigns.nvim",
			{
				"tpope/vim-fugitive",
				cmd = { "Git", "G" },
			},

			-- comments
			{
				"numToStr/Comment.nvim",
				config = "require 'Comment'.setup {}",
			},

			-- debugging
			{
				"rcarriga/nvim-dap-ui",
				requires = "mfussenegger/nvim-dap",
			},
			{
				"microsoft/vscode-js-debug",
				opt = true,
				run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				requires = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug" },
			},
			"theHamsta/nvim-dap-virtual-text",
			"David-Kunz/jester",

			-- tools (like a swiss-knife)
			"echasnovski/mini.nvim",

			{
				"iamcco/markdown-preview.nvim",
				run = "cd app && npm install",
				setup = function()
					vim.g.mkdp_filetypes = { "markdown" }
				end,
				ft = { "markdown" },
			},
			"nvim-lualine/lualine.nvim",
		})
	end,
	config = { max_jobs = 32 },
})
