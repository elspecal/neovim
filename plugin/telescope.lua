local ok, telescope = pcall(require, "telescope")
if not ok then
  print "failed to load telescope"
  return
end

telescope.load_extension "fzf"
