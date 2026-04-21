vim.opt.history = 1000
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.cmd("set nowrap")
vim.g.mapleader = " "
vim.deprecate = function() end

require("plugins.treesitter")
require("plugins.colorscheme")
require("plugins.ui")
require("plugins.misc")
require("plugins.lsp")
