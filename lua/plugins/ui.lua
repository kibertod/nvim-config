-- nvim-tree setup
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-tree/nvim-tree.lua",
})
require("nvim-tree").setup({
	filters = { dotfiles = false },
	git = { enable = true, ignore = false },
})
vim.keymap.set("n", "<leader>tt", "<CMD>:NvimTreeToggle<CR>")

-- lualine setup
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/noice.nvim",
})
require("lualine").setup({
	options = {
		section_separators = { right = "", left = "" },
		component_separators = { right = "", left = "" },
	},
	sections = {
		lualine_a = {
			"branch",
		},
		lualine_b = { "filename" },
		lualine_c = {
			"filetype",
			"encoding",
		},
		lualine_x = {
			{ "diagnostics", symbols = { error = " ", warn = " ", info = " " } },
		},
		lualine_y = {
			{
				"diff",
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
			},
		},
		lualine_z = { "progress", "location" },
	},
})

-- trouble setup
vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>")
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>")
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>")

-- indent blankline setup
vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup({
	scope = {
		enabled = false,
	},
	indent = {
		char = "╎",
	},
	exclude = {
		filetypes = {
			"lspinfo",
			"packer",
			"checkhealth",
			"help",
			"man",
			"gitcommit",
			"TelescopePrompt",
			"TelescopeResults",
			"''",
			"dashboard",
		},
	},
})

-- lazygit setup
vim.pack.add({ "https://github.com/kdheepak/lazygit.nvim" })
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")

-- toggleterm setup
vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })
require("toggleterm").setup()
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>")

-- bufferline setup
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/Asheq/close-buffers.vim",
})
require("bufferline").setup({
	options = {
		offsets = {
			{ filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
		},
	},
})
vim.keymap.set("n", "<leader>bd", "<CMD>Bdelete hidden<CR>")
vim.keymap.set("n", ",", "<CMD>bp<CR>")
vim.keymap.set("n", ".", "<CMD>bn<CR>")

-- aerial setup
vim.pack.add({ "https://github.com/stevearc/aerial.nvim" })
require("aerial").setup({
	backends = { "treesitter", "lsp" },
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "K", "<cmd>AerialPrev<CR>", { buffer = bufnr })
vim.keymap.set("n", "J", "<cmd>AerialNext<CR>", { buffer = bufnr })

-- telescope setup
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = "➜ ",
		mappingsd = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
})
telescope.load_extension("ui-select")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})

-- todo-comments setup
vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/folke/todo-comments.nvim",
})
vim.keymap.set("n", "<leader>td", "<CMD>TodoTelescope<CR>")
