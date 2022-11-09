-- local oksline, sline = pcall(require, "mini.statusline")
local oksline, sline = pcall(require, "lualine")
if not oksline then
	-- print("failed to load mini.statusline")
	print("failed to load lualine")
else
	sline.setup({})
end
