local g = vim.g
local o = vim.o
local opt = vim.opt
local indent = 2

g.mapleader = " "

o.number = true
o.relativenumber = true
o.timeoutlen = 400
opt.clipboard:append { "unnamedplus" }
o.termguicolors = true
opt.completeopt = { "menu", "menuone", "noselect" }
o.autowriteall = true
o.confirm = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.list = true
o.scrolloff = 8
o.shiftwidth = indent
o.tabstop = indent
o.expandtab = true
o.signcolumn = "yes"
o.smartindent = true
o.undofile = true
o.undolevels = 10000
o.wrap = false

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
