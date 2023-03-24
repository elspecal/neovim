local ok, saga = pcall(require, "lspsaga")
if not ok then
	print("failed to load lsp-saga")
	return
end

saga.setup({
	ui = {
		border = "rounded",
	},
	lightbulb = {
		sign = false,
	},
	--[[ finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	}, ]]
})
