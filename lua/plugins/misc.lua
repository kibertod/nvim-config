-- flash setup
vim.pack.add({"https://github.com/folke/flash.nvim"})
vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end)

-- auto-pairs setup
vim.pack.add({"https://github.com/windwp/nvim-autopairs"})
require("nvim-autopairs").setup()

-- auto-session setup
vim.pack.add({"https://github.com/rmagatti/auto-session"})
require("auto-session").setup({suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" }})
