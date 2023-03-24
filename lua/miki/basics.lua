local g = vim.g
local o = vim.o
local opt = vim.opt
local indent = 4

g.mapleader = " "
g.python3_host_prog = "$HOME/projects/HearsayLabs/.venv/bin/python"

o.number = true
o.relativenumber = true
o.timeoutlen = 750
opt.clipboard:append({ "unnamedplus" })
o.termguicolors = true
opt.completeopt = { "menu", "menuone", "noselect" }
o.autowriteall = true
o.confirm = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.list = true
opt.listchars:append({
	trail = "-",
	eol = "↵",
	tab = "<->",
	multispace = "·",
	leadmultispace = "·",
})
o.scrolloff = 8
o.shiftwidth = indent
o.tabstop = indent
o.expandtab = true
o.signcolumn = "yes"
o.smartindent = true
o.undofile = true
o.undolevels = 10000
o.wrap = false
o.mouse = "a"
opt.sessionoptions = { "buffers", "options" }
o.updatetime = 1500
opt.diffopt:append({ "iwhite" })
o.splitright = true
o.splitbelow = true

local builtins = {
	"gzip",
	"zip",
	"zipPlugin",
	"fzf",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"matchit",
	"matchparen",
	"logiPat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
	g["loaded_" .. plugin] = 1
end
