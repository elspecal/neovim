local ok, mnl = pcall(require, "mason-null-ls")
if not ok then
  print "failed to load mason-null-ls"
  return
end

mnl.setup {
  automatic_installation = true,
}
