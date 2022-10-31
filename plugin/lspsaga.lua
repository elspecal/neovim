local ok, saga = pcall(require, "lspsaga")
if not ok then
	print("failed to load lsp-saga")
	return
end

saga.init_lsp_saga({
	border_style = "rounded",
	code_action_lightbulb = {
		sign = false,
	},
	finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	},
})
