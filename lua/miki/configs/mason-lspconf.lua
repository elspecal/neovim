local ok_masonlspconf, mason_lspconf = pcall(require, "mason-lspconfig")
if not ok_masonlspconf then
  print("failed to run mason-lspconfig")
  return
end

mason_lspconf.setup({ automatic_installation = true })
