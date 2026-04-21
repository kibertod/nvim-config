vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})
require("nvim-treesitter").install({
	"bash",
	"c",
	"cpp",
	"diff",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"c_sharp",
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
