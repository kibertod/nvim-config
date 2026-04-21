-- lsp-config setup
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/Decodetalkers/csharpls-extended-lsp.nvim",
	"https://github.com/Hoffs/omnisharp-extended-lsp.nvim",
})

local lsps = {
	"rust_analyzer",
	"pyright",
	"emmet_language_server",
	"clangd",
	"ts_ls",
	"lua_ls",
}

for _, lsp in ipairs(lsps) do
	vim.lsp.enable(lsp)
end

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				reportOptionalMemberAccess = false,
				reportOptionalCall = false,
				reportOptionalSubscript = false,
				reportOptionalOperand = false,
			},
		},
	},
})

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = { true, prefix = "●" },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- mason setup
vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})
require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
})

-- nvim-cmp setup
vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/FelipeLema/cmp-async-path",
	"https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/onsails/lspkind.nvim",
})
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
		menu = { border = "rounded" },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "async_path" },
		{ name = "nvim_lsp_signature_help" },
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = 0,
			side_padding = 0,
		}),
	},
	formatting = {
		expandable_indicator = true,
		fields = { "icon", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.icon, "%s", { trimempty = true })
			kind.icon = " " .. (strings[1] or "") .. " "
			return kind
		end,
	},
})

-- lazydev setup
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
require("lazydev").setup({
	ft = "lua",
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

-- conform setup
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },
		javascript = { "biome" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		cs = { "clang-format" },
		css = { "prettierd" },
		scss = { "prettierd" },
		json = { "jq" },
		html = { "prettierd" },
		toml = { "taplo" },
	},
	formatters = {
		rustfmt = {
			prepend_args = { "--config-path", "/home/kibertod/.config/rustfmt/rustfmt.toml" },
		},
	},
})
vim.keymap.set("n", "<leader>F", require("conform").format)

-- roslyn setup
vim.pack.add({ "https://github.com/seblyng/roslyn.nvim" })
