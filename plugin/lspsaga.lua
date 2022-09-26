local ok, saga = pcall(require, "lspsaga")
if not ok then
  print("failed to load lsp-saga")
  return
end

saga.init_lsp_saga({})
