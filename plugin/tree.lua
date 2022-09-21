local ok, neotree = pcall(require, "neo-tree")
if not ok then
  print "failed to load neo-tree"
  return
end

vim.cmd "let g:neo_tree_remove_legacy_commands = 1"

neotree.setup {
  close_if_last_window = true,
  window = { position = "right" },
  filesystem = {
    filtered_items = { hide_dotfiles = false },
  },
}
