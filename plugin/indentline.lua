local ok, indentline = pcall(require, "indent_blankline")
if not ok then
  print "failed to load indent-blankline plugin"
  return
end

indentline.setup {
  use_treesitter = true,
  show_current_context = true,
}
