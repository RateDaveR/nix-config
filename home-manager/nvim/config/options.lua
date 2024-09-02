vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Line numbers plus relative unnubmers.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line Wraps
vim.opt.smartindent = true
vim.opt.wrap = false

-- We dont want to do any backs. But instead use undo tree plugin, and give it access to long running undos.
-- We should be able to undo changes from days ago. One of the reaosn looking to move form vscode.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- We don't want to highlight the whole word. But instead we should hight as we serach. 
-- For example if you serach this file for /vim, /vim.* and /vim.* =
vim.opt.hlsearch = false
vim.opt.incsearch = true


-- As you go down wont have >8 char at the bottom and <8 char at the top of the file. Execpt at end of file.
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Misc
vim.opt.updatetime = 50
vim.opt.termguicolors = true
vim.guicursor = ""
vim.opt.colorcolumn = "80"

