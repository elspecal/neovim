local oksrnd, surround = pcall(require, "mini.surround")
if not oksrnd then
	print("failed to load mini.surround")
else
	surround.setup()
end

local oksline, sline = pcall(require, "mini.statusline")
if not oksline then
	print("failed to load mini.statusline")
else
	sline.setup()
end
