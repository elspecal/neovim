local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  print "failed to start treesitter"
  return
end
treesitter.setup {
  ensure_installed = {
    "css",
    "gitignore",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "regex",
    "tsx",
    "typescript",
    "yaml"
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indentation = { enable = true },
}
