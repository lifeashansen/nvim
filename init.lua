vim.g.mapleader = " "

local o = vim.opt

o.number = true
o.relativenumber = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.undofile = true
o.swapfile = false
o.termguicolors = true
o.scrolloff = 10

o.winborder = "single"

local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	{ src = gh("nvim-treesitter/nvim-treesitter"), name = "nvim-treesitter" },
	{ src = gh("nvim-mini/mini.nvim"), name = "mini.nvim" },
	-- Blink cmp
	{ src = gh("saghen/blink.lib"), name = "blink.lib" },
	{ src = gh("saghen/blink.cmp"), name = "blink.cmp" },

	-- gh("stevearc/oil.nvim.git"),
	{ src = gh("stevearc/conform.nvim"), name = "conform" },
	{ src = gh("vyfor/cord.nvim"), name = "cord" },
	{ src = gh("wakatime/vim-wakatime"), name = "wakatime" },
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	{ src = gh("ibhagwan/fzf-lua"), name = "fzf-lua" },
	{ src = gh("stevearc/oil.nvim"), name = "oil" },
	-- Neotree
	{ src = gh("nvim-neo-tree/neo-tree.nvim") },
	-- dependencies
	{ src = gh("nvim-lua/plenary.nvim"), name = "plenary" },
	{ src = gh("MunifTanjim/nui.nvim"), name = "nui" },
	-- optional, but recommended
	{ src = gh("nvim-tree/nvim-web-devicons"), name = "nvim-web-devicons" },

	-- Snacks
	{ src = gh("folke/snacks.nvim"), name = "snacks.nvim" },

	-- Mason + Lsp
	{ src = gh("mason-org/mason.nvim"), name = "mason.nvim" },
	{ src = gh("mason-org/mason-lspconfig.nvim"), name = "mason.lspconfig" },
	{ src = gh("neovim/nvim-lspconfig"), name = "nvim-lspconfig" },

	--Trouble
	{ src = gh("folke/trouble.nvim"), name = "trouble.nvim" },
})

-- -- Only after first installation or updates
-- local cmp = require("blink.cmp")
-- cmp.build():pwait()
-- cmp.setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"clangd",
		"svelte",
		"ruff",
		"ty",
		"ts_ls",
		"terraformls",
		"cssls",
		"ansiblels",
	},
	automatic_enable = {
		"lua_ls",
		"go",
		"clangd",
		"svelte-language-server",
		"ruff",
		"ty",
		"ts_ls",
		"terraformls",
		"cssls",
		"ansiblels",
		exclude = {},
	},
})

-- vim.lsp.enable({ "lua_ls", "clangd", "gopls", "ruff", "rust_analyzer", "ty", "svelte" })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
})

require("mini.starter").setup()
require("oil").setup()
require("cord").setup()
require("wakatime").setup()
require("mini.icons").setup()
require("mini.files").setup()
require("mini.pairs").setup()
require("mini.tabline").setup()
-- require("mini.statusline").setup()
-- require("mini.completion").setup()
require("neo-tree").setup({})
require("blink.cmp").setup()

require("nvim-treesitter").setup({
	ensure_installed = {
		"help",
		"lua",
		"c",
		"cpp",
		"go",
		"python",
		"rust",
		"zig",
		"svelte",
		"typescript",
		"javascript",
		"css",
		"bash",
		"nix",
		"json",
		"yaml",
		"toml",
		"ansible",
		"terraform",
	},
	auto_install = true,
	highlight = {
		enable = true,
	},
})

require("trouble").setup({})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettierd" },
		go = { "gofmt" },
		rust = { "rustfmt" },
		py = { "ruff" },
		svelte = { "prettierd" },
		typescript = { "prettierd" },
		javascript = { "prettierd" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.keymap.set("n", "<Leader>e", "<CMD>Neotree position=float<Cr>")
vim.keymap.set("n", "<Leader>ff", "<CMD>FzfLua files<Cr>")
vim.keymap.set("n", "<Leader>fb", "<CMD>FzfLua buffers<Cr>")
vim.keymap.set("n", "<Leader>d", function()
	vim.diagnostic.setqflist({ bufnr = 0 })
end)
vim.keymap.set("n", "<Leader>dx", "<CMD>cclose<Cr>")

vim.keymap.set("n", "<Leader>x", "<CMD>bdelete<Cr>")

vim.diagnostic.config({
	virtual_lines = false,
})

local langs = { "svelte", "c", "cpp", "python", "javascript", "typescript", "css", "terraform", "ansible" }

for _, lang in pairs(langs) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { lang },
		callback = function()
			vim.treesitter.start()
		end,
	})
end
