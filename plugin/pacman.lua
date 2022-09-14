local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
	print "failed to run mason"
	return
end

local ok_masonlspconf, mason_lspconf = pcall(require, "mason-lspconfig")
if not ok_masonlspconf then
	print "failed to run mason-lspconfig"
	return
end

mason.setup {}
mason_lspconf.setup { automatic_installation = true }
