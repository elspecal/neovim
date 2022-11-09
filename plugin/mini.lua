local oksrnd, surround = pcall(require, "mini.surround")
if not oksrnd then
	print("failed to load mini.surround")
else
	surround.setup({})
end
