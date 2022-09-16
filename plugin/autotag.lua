local ok, autotag = pcall(require, "nvim-ts-autotag")
if not ok then
  print "failed to load nvim-ts-autotag"
  return
end

autotag.setup {}
