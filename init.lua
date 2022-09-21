require "miki.basics"
require "miki.plugins"
require "miki.maps"
require "miki.commands"
require "miki.lsp"

local ok = pcall(require, "impatient")
if not ok then
  print "failed to load impatient"
  return
end
